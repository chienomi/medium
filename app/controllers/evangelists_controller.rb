class EvangelistsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_evangelist, only: [:show,:update,:destroy,:edit,:repeat]
  before_filter :authenticate_user!, only: [:destroy, :create, :update]

  # added to redirect to the current page after logged in 2016/1/23
  before_filter :store_current_location, :unless => :devise_controller?
  def store_current_location
    store_location_for(:user, request.url)
  end

  def evangelion
    eva = Evangelist.friendly.find(params[:id])
    if user_signed_in?
      user = current_user
      user.eva_id = eva.id
      user.save!
    end
    id_to = eva.demo_id
    go_to = Demo.find_by(id: id_to)
    redirect_to go_to
  end

  # GET /evangelists
  # GET /evangelists.json
  def index_comment
    @user = current_user
    if user_signed_in?
      @bantags = @user.hates
      @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
    end
    @search_title = params['cate_send']

    @index_tag = 0
    gon.index_tag = 0

      if params[:category] && @user != nil
        @evangelists_topic = Evangelist.category_of(params[:category]).where.not(id: @exclude_ids).where.not(taglock: 2).order("rating DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(12)
        @topic_size = Evangelist.category_of(params[:category]).size
        #okini is defed by categories
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(6)
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @user.categories).where.not('id' => @bantags).where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @search_type = 0
      elsif params[:category]
        @evangelists_topic = Evangelist.vocaloid.category_of(params[:category]).where.not(taglock: 2).order("rating DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(12)
        @topic_size = Evangelist.category_of(params[:category]).size
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(6)
        @evangelists = Evangelist.vocaloid.where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @search_type = 0
      elsif @user != nil
        @evangelists_topic = Evangelist.where.not(id: @exclude_ids).where.not(taglock: 2).order("rating DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(12)
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(6)
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @user.categories).where.not('id' => @bantags).where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
      else
        @evangelists_topic = Evangelist.order("rating DESC").where.not(taglock: 2).paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(9)
        @evangelists = Evangelist.where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @categories = @categories_topic.limit(5)
      end
      @index_style = 2
end

def index_new
      @user = current_user
    if user_signed_in?
      @bantags = @user.hates
      @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
    end
    @search_title = params['cate_send']

    @index_tag = 0
    gon.index_tag = 0

      if params[:category] && @user != nil
        @evangelists_topic = Evangelist.category_of(params[:category]).where.not(id: @exclude_ids).where.not(taglock: 2).order("evangelists.created_at DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(9)
        @topic_size = Evangelist.category_of(params[:category]).size
        #okini is defed by categories
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(5)
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @user.categories).where.not('id' => @bantags).where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @search_type = 0
      elsif params[:category]
        @evangelists_topic = Evangelist.vocaloid.category_of(params[:category]).where.not(taglock: 2).order("evangelists.created_at DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(9)
        @topic_size = Evangelist.vocaloid.category_of(params[:category]).size
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(5)
        @evangelists = Evangelist.where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @search_type = 0
      elsif @user != nil
        @evangelists_topic = Evangelist.where.not(id: @exclude_ids).where.not(taglock: 2).order("evangelists.created_at DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(9)
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(5)
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @user.categories).where.not('id' => @bantags).where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
        @evangelists_okini_news = @evangelists
      else
        @evangelists_topic = Evangelist.order("evangelists.created_at DESC").where.not(taglock: 2).paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(9)
        @evangelists = Evangelist.where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @categories = @categories_topic.limit(5)
      end
      @index_style = 1
      render 'index'
end

def index
    @user = current_user
    if user_signed_in?
      @bantags = @user.hates
      @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
    end
    @search_title = params['cate_send']

    @index_tag = 0
    gon.index_tag = 0

        if params[:category] && @user != nil
        @evangelists_topic = Evangelist.category_of(params[:category]).where.not(id: @exclude_ids).where.not(taglock: 2).order("evangelists.c_updated_at DESC, evangelists.updated_at DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(9)
        @topic_size = Evangelist.category_of(params[:category]).size
        #okini is defed by categories
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(6)
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @user.categories).where.not('id' => @bantags).where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @search_type = 0
      elsif params[:category]
        @evangelists_topic = Evangelist.category_of(params[:category]).where.not(taglock: 2).order("evangelists.c_updated_at DESC, evangelists.updated_at DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(9)
        @topic_size = Evangelist.category_of(params[:category]).size
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(5)
        @evangelists = Evangelist.where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @search_type = 0
      elsif @user != nil
        @evangelists_topic = Evangelist.where.not(id: @exclude_ids).where.not(taglock: 2).order("evangelists.c_updated_at DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(9)
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(5)
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @user.categories).where.not('id' => @bantags).where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
      else
        @evangelists_topic = Evangelist.order("evangelists.c_updated_at DESC, evangelists.updated_at DESC").where.not(taglock: 2).paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(10)
        @evangelists = Evangelist.where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @categories = @categories_topic.limit(5)
      end

      @index_style = 0
      render 'index'
end

def category_new
      @user = current_user
    if user_signed_in?
      @bantags = @user.hates
      @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
    end
    @search_title = params['cate_send']

    @index_tag = 0
    gon.index_tag = 0

      if params[:category] && @user != nil
        @evangelists_topic = Evangelist.category_of(params[:category]).where.not(id: @exclude_ids).where.not(taglock: 2).order("evangelists.created_at DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(12)
        @topic_size = Evangelist.category_of(params[:category]).size
        #okini is defed by categories
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(6)
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @user.categories).where.not('id' => @bantags).where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
      elsif params[:category]
        @evangelists_topic = Evangelist.category_of(params[:category]).where.not(taglock: 2).order("evangelists.created_at DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(12)
        @topic_size = Evangelist.category_of(params[:category]).size
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(6)
        @evangelists = Evangelist.where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
      end
      @search_type = 1
      render 'index'
end

def category_rank
      @user = current_user
    if user_signed_in?
      @bantags = @user.hates
      @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
    end
    @search_title = params['cate_send']

    @index_tag = 0
    gon.index_tag = 0

      if params[:category] && @user != nil
        @evangelists_topic = Evangelist.category_of(params[:category]).where.not(id: @exclude_ids).where.not(taglock: 2).order("views_e DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(24)
        @topic_size = Evangelist.vocaloid.category_of(params[:category]).size
        #okini is defed by categories
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).where.not('id' => @bantags).order("categories.rating DESC").limit(6)
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @user.categories).where.not('id' => @bantags).where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
      elsif params[:category]
        @evangelists_topic = Evangelist.category_of(params[:category]).where.not(taglock: 2).order("views_e DESC").paginate(:per_page => 24, :page => params[:page])
        @categories_topic = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(24)
        @topic_size = Evangelist.category_of(params[:category]).size
        @categories = Category.joins(:evangelists).distinct.where('evangelists.id' => @evangelists_topic).order("categories.rating DESC").limit(6)
        @evangelists = Evangelist.where.not(taglock: 2).order("created_at DESC").paginate(:per_page => 6, :page => params[:page])
        @evangelists_okini_news = @evangelists
      end
      @search_type = 2
      render 'index'
end

  def search
    # Rails.logger.level = Logger::DEBUG
    @user = current_user
    @search_title = params['search']
    @user = current_user
    if user_signed_in?
      @bantags = @user.hates
      @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
    end
    @index_tag = 0
    gon.index_tag = 0
    if params[:category]
        @categories_topic = Category.where('id' => params[:category]).where.not('id' => @bantags).order("rating DESC").limit(12)
        @evangelists_topic = Evangelist.category_of(params[:category]).order("rating DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = Evangelist.category_of(params[:category]).size
    elsif params['search']
        @categories_topic = Category.search(params[:search]).where.not('id' => @bantags).order("rating DESC").limit(12)
        @topic_tag_size = Category.search(params[:search]).where.not('id' => @bantags).size
        @evangelists_topic = Evangelist.search(params[:search]).where.not(id: @exclude_ids).order("rating DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = Evangelist.search(params[:search]).size
      else
        @evangelists_topic = Evangelist.order("rating DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = @evangelists_topic.size
      end
      @search_type = 0
  end

    def search_new
    # Rails.logger.level = Logger::DEBUG
    @user = current_user
    @search_title = params['search']
    @user = current_user
    if user_signed_in?
      @bantags = @user.hates
      @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
    end
    @index_tag = 0
    gon.index_tag = 0
    if params[:category]
        @categories_topic = Category.where('id' => params[:category]).where.not('id' => @bantags).order("created_at DESC").limit(12)
        @evangelists_topic = Evangelist.category_of(params[:category]).order("created_at DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = Evangelist.category_of(params[:category]).size
    elsif params['search']
        @categories_topic = Category.search(params[:search]).where.not('id' => @bantags).order("created_at DESC").limit(12)
        @topic_tag_size = Category.search(params[:search]).where.not('id' => @bantags).size
        @evangelists_topic = Evangelist.search(params[:search]).where.not(id: @exclude_ids).order("created_at DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = Evangelist.search(params[:search]).size
      else
        @evangelists_topic = Evangelist.order("created_at DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = @evangelists_topic.size
      end
      @search_type = 1
      render 'search'
  end

    def search_rank
    # Rails.logger.level = Logger::DEBUG
    @user = current_user
    @search_title = params['search']
    @user = current_user
    if user_signed_in?
      @bantags = @user.hates
      @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
    end
    @index_tag = 0
    gon.index_tag = 0
    if params[:category]
        @categories_topic = Category.where('id' => params[:category]).where.not('id' => @bantags).order("rating DESC").limit(12)
        @evangelists_topic = Evangelist.category_of(params[:category]).order("views_e DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = Evangelist.category_of(params[:category]).size
    elsif params['search']
        @categories_topic = Category.search(params[:search]).where.not('id' => @bantags).order("rating DESC").limit(12)
        @topic_tag_size = Category.search(params[:search]).where.not('id' => @bantags).size
        @evangelists_topic = Evangelist.search(params[:search]).where.not(id: @exclude_ids).order("views_e DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = Evangelist.search(params[:search]).size
      else
        @evangelists_topic = Evangelist.order("views_e DESC").paginate(:per_page => 24, :page => params[:page])
        @topic_size = @evangelists_topic.size
      end
      @search_type = 2
      render 'search'
  end

  def index_cate
    @categories = Category.order("rating DESC").limit(24)
    @search_title = params['cate']
  end
  def redirection
    @evangelist = Evangelist.friendly.find(params[:title])
    @evangelist_id = Evangelist.find_by(id: params[:title])
    if  @evangelist_id != nil && params[:title] == params[:title].to_i.to_s
      redirect_to @evangelist_id
      puts "redirected!"
    else
      redirect_to @evangelist
    end
  end

  # GET /evangelists/1
  # GET /evangelists/1.json
  def show
    ActiveRecord::Base.record_timestamps = false
    @user_p_mo = @user_p.evangelists.where("created_at > ?", 1.month.ago).size
    @index_tag = 1
    gon.index_tag = 1

    @categories = @evangelist.categories
    next_video
    # puts "end n_v and ...show"

    if session[:watch] == nil
      session[:watch] = []
      @evangelist.views = @evangelist.views + 1
      @evangelist.views_e = @evangelist.views_e + 1
      session[:watch] << @evangelist.id
    elsif !session[:watch].include?(@evangelist.id)
        @evangelist.views = @evangelist.views + 1
      @evangelist.views_e = @evangelist.views_e + 1
      session[:watch] << @evangelist.id
    end

    @evangelist.save!

    if user_signed_in?
      @current_like = current_user.likes.find_by(evangelist_id: @evangelist.id)
      @notmyself = (@evangelist.id != @user.id)
    end

    @conversations = @evangelist.conversations.hash_tree

    gon.short_url="https://graphnote.com/blog/"+@evangelist.id.to_s
    # @come = []
    # @evangelist.conversations.each{|c| @come << [c.body, c.time]}
    # gon.come = @come
    ActiveRecord::Base.record_timestamps = true
  end

  def repeat
    if params['repeat'] == "1"
        @repeat = 1
    else
        @repeat = 0
    end
    next_video
    puts "end n_v and ...repeat"
    render 'repeat.js'
  end

  # GET /evangelists/new
  def new
      @evangelist = Evangelist.new
      @user = current_user
  end

  # GET /evangelists/1/edit
  def edit
    set_evangelist
    #edit start
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by(id: 4)
    end
  end

  def yt
    # Rails.logger.level = Logger::DEBUG
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by(id: 4)
    end
    require 'open-uri'
    require 'addressable/uri'
    @yt_url = params['yt']

    # twitter
    if @yt_url.include?("youtu.be/")
      @yt_url["youtu.be/"] = "www.youtube.com/watch?v="
    end

    @yt_id = @yt_url.gsub(/[=&?]/, ' ').split(" ")[2]

    @evangelist = Evangelist.find_by(yt_id: @yt_id)
    if @evangelist != nil
      redirect_to @evangelist
    end

      @yt_img0 = "https://img.youtube.com/vi/" + @yt_id + "/mqdefault.jpg"
      @yt_img1 = "https://img.youtube.com/vi/" + @yt_id + "/1.jpg"
      @yt_img2 = "https://img.youtube.com/vi/" + @yt_id + "/2.jpg"
      @yt_img3 = "https://img.youtube.com/vi/" + @yt_id + "/3.jpg"

    begin
        html = open(Addressable::URI.parse(@yt_url.strip),
        :allow_redirections => :all,
        :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0.1) Gecko/20100101 Firefox/9.0.1") do |data|
          data.read
        end
    rescue => e
        puts "open uri error..."
        puts e.message
        puts ""
    end

    begin
        doc = Nokogiri::HTML.parse(html)
        @yt_title = doc.at_css("title").text
        @yt_duration = doc.at_css(".video-time").text.strip
    rescue => e
        puts "Nokogiri error..."
        puts e.message
        puts ""
    end

    @yt_title.chop!.chop!.chop!.chop!.chop!.chop!.chop!.chop!.chop!.chop!

    puts "url..." + @yt_url
    puts "id..." + @yt_id
    gon.yt_url = @yt_url
    gon.yt_id = @yt_id
    gon.yt_title = @yt_title
    gon.yt_img0 = @yt_img0
    gon.yt_img1 = @yt_img1
    gon.yt_img2 = @yt_img2
    gon.yt_img3 = @yt_img3
    gon.yt_duration = @yt_duration

    @evangelist = Evangelist.new
  end

  # POST /evangelists
  # POST /evangelists.json
  def create

    if user_signed_in?
      @user = current_user
    end
    @evangelist = Evangelist.new(evangelist_params)

    if user_signed_in?
      @evangelist.user_id = @user.id
      @evangelist.user_name = @user.user_name
    end

    @evangelist.title = @evangelist.title.gsub(/&nbsp;/," ").strip.delete("\n").delete("\r").gsub(/<\/?([a-z]+)([^>]+)*(?:>)/,"").strip
    @evangelist.paragraph1 = @evangelist.paragraph1.strip.gsub(/&nbsp;/," ").gsub(/<div class=\"medium-insert-buttons\".*div>/m,"").gsub(/<br>*/m,"<br>").gsub(/&nbsp;/," ")
    @evangelist.extra = @evangelist.extra.strip.gsub(/<div class=\"medium-insert-buttons\".*div>/m,"").gsub(/<br>*/m,"<br>").gsub(/&nbsp;/," ")
    full_story = @evangelist.paragraph1 + @evangelist.extra

    # time start
    r_s = (@evangelist.paragraph1.to_s.gsub(/<([^>]+)*>/,"").scan(/\b/).size/2 + @evangelist.extra.to_s.gsub(/<([^>]+)*>/,"").scan(/\b/).size/2)*60/114
    r_m = r_s/60
    r_s = r_s - r_m*60
    if r_s < 10
      r_s = "0" + r_s.to_s
    end
    @evangelist.yt_duration = r_m.to_s + ":" + r_s.to_s
    # time end

    # replace start
    @str_count = @evangelist.str_count

    @cooked_str = ""
    @ingredient = @evangelist.paragraph1

    #/<\/?([a-z]+)([^>]+)*(?:>)/
    #/(<\/?i>|<\/?p>|<p class=\".*>|<\/?b>|<\/?def>|<span class=\".*\">|<\/?math>|<\/?semantics>|<\/?mrow>|<\/?mi>|<\/?div .*><img src=.*>|<\/?figure .*>|<\/?annotation .*>)/m
    while @ingredient != ""
          @a_parts = @ingredient.partition(/(<span class=\"c_str_([^>]+)*>(([^>]+)*)\/span>|<!\-\-([^\-\->]+)*\-\->|<\/?([a-z]+)([^>]+)*(?:>))/)
          if @a_parts[0] == ""
            @cooked_str << @a_parts[1]
            @ingredient = @a_parts[2]
          else
            while @a_parts[0] != ""
              if (/[^A-Za-z0-9_,:;éîüåø=\*\@\$\%\(\)\{\}\[\]]/.match(@a_parts[0].chr) == nil)
                @cooked_str << "<span class=\"c_str_" + @str_count.to_s + "\">" + @a_parts[0].chr + "</span>"
              else
                @cooked_str << @a_parts[0].chr
              end
              @a_parts[0][0] = ""
              @str_count = @str_count + 1
            end
            @cooked_str << @a_parts[1]
            @ingredient = @a_parts[2]
          end
    end
        @evangelist.paragraph1 = @cooked_str

        @cooked_str = ""
        @ingredient = @evangelist.extra

        while @ingredient != ""
          @a_parts = @ingredient.partition(/(<span class=\"c_str_([^>]+)*>(([^>]+)*)\/span>|<!\-\-([^\-\->]+)*\-\->|<\/?([a-z]+)([^>]+)*(?:>))/)
          if @a_parts[0] == ""
            @cooked_str << @a_parts[1]
            @ingredient = @a_parts[2]
          else
            while @a_parts[0] != ""
              if /[^A-Za-z0-9_.,:;\*\@\$\%\(\)\{\}\[\]]/.match(@a_parts[0].chr) == nil
                @cooked_str << "<span class=\"c_str_" + @str_count.to_s + "\">" + @a_parts[0].chr + "</span>"
              else
                @cooked_str << @a_parts[0].chr
              end
              @a_parts[0][0] = ""
              @str_count = @str_count + 1
            end
            @cooked_str << @a_parts[1]
            @ingredient = @a_parts[2]
          end
        end
        @evangelist.extra = @cooked_str

        @evangelist.str_count = @str_count
        # replace end

      # thumb start
      doc = Nokogiri::HTML.parse(@evangelist.paragraph1)
      i_url_pre = doc.at_css("img")
      if i_url_pre != nil
        i_url = i_url_pre.attributes["src"].value
      else
        i_url = ""
      end
      @evangelist.yt_img0 = i_url
      #thumb end

    # create prime tags
    @evangelist.prime_tag = @evangelist.categories.map(&:name).join(" ")
    #tag for nil
    @locked_tag = @evangelist.prime_tag
    if @locked_tag.include?("ActiveRecord")
      @evangelist.prime_tag = ""
    end
    #tags conf for white spaces
    @evangelist.prime_tag.gsub!(/\s/," ")
      flag = 0
      while flag == 0 do
        if @evangelist.prime_tag.include?("　")
          @evangelist.prime_tag["　"] = " "
        end
        if !@evangelist.prime_tag.include?("　")
          flag = 1
        end
      end

      #title
      if @evangelist.title == @evangelist.title.to_i.to_s
        @evangelist.title = 'b' + @evangelist.title
      end

    @evangelist.created_at = Time.now
    @evangelist.updated_at = 3.years.ago

    #rating
    denomi = (0.0/(60*60*30) + 2 )**1.2
    nume = @evangelist.likes_e + 2 + @evangelist.views_e*0.01 + @evangelist.come_e*0.05
    @evangelist.rating = nume/denomi

    #created_at
    @evangelist.c_updated_at = 3.years.ago

    respond_to do |format|
      if @evangelist.save
        format.html { redirect_to @evangelist, notice: 'Nice! This is your #' + @user.evangelists.size.to_s + ' material' }
        format.json { render :show, status: :created, location: @evangelist }
      else
        format.html { render :new }
        format.json { render json: @evangelist.errors, status: :unprocessable_entity }
      end
    end
  end

  def play_this
    #this has a role of "set evangelist"
      @evangelist = Evangelist.find_by(id: params[:evangelist_id])
      @user = current_user

    if @user != nil
      @user.playnext = []
      playlist_now = Playlist.find_by(id: params["playlist_id"])
      @user.playlist_now = params["playlist_id"]
      @user.playnext = playlist_now.likes.order('likes.playorder ASC').pluck(:evangelist_id).uniq
      @user.save!
      next_video
    end
    render 'playthis.js'
  end

  # PATCH/PUT /evangelists/1
  # PATCH/PUT /evangelists/1.json
  def update
    @user = current_user

    @locked_tag = @evangelist.prime_tag
    if @locked_tag.include?("ActiveRecord")
      @evangelist.prime_tag = ""
      @evangelist.save!
    end

    #tags conf for white spaces
    @evangelist.prime_tag.gsub!(/\s/," ")
      flag = 0
      while flag == 0 do
        if @evangelist.prime_tag.include?("　")
          @evangelist.prime_tag["　"] = " "
        end
        if !@evangelist.prime_tag.include?("　")
          flag = 1
        end
      end

      doc = Nokogiri::HTML.parse(@evangelist.paragraph1)
      i_url_pre = doc.at_css("img")
      if i_url_pre != nil
        i_url = i_url_pre.attributes["src"].value
      else
        i_url = ""
      end
      @evangelist.yt_img0 = i_url

    respond_to do |format|
      if @evangelist.update(evangelist_params)
        @evangelist.title = @evangelist.title.gsub(/&nbsp;/," ").strip.delete("\n").delete("\r").gsub(/<\/?([a-z]+)([^>]+)*(?:>)/,"").strip
        @evangelist.paragraph1 = @evangelist.paragraph1.strip.gsub(/<div class=\"medium-insert-buttons\".*div>/m,"").gsub(/&nbsp;/," ").strip
        @evangelist.extra = @evangelist.extra.strip.gsub(/<div class=\"medium-insert-buttons\".*div>/m,"").gsub(/&nbsp;/," ").strip

      r_s = (@evangelist.paragraph1.to_s.gsub(/<([^>]+)*>/,"").scan(/\b/).size/2 + @evangelist.extra.to_s.gsub(/<([^>]+)*>/,"").scan(/\b/).size/2)*60/114
      r_m = r_s/60
      r_s = r_s - r_m*60
      if r_s < 10
        r_s = "0" + r_s.to_s
      end
      @evangelist.yt_duration = r_m.to_s + ":" + r_s.to_s

      # thumb start
      doc = Nokogiri::HTML.parse(@evangelist.paragraph1)
      i_url_pre = doc.at_css("img")
      if i_url_pre != nil
        i_url = i_url_pre.attributes["src"].value
      else
        i_url = ""
      end
      @evangelist.yt_img0 = i_url
      #thumb end

        # replace start
        @str_count = @evangelist.str_count

        @cooked_str = ""
        @ingredient = @evangelist.paragraph1 #.gsub(/<span class=\"c_str_([^>]+)*>([^>])([^>]+)<\/span>/,'<span class="c_str_\1>\2</span>\3')

          #/<\/?([a-z]+)([^>]+)*(?:>)/
          #/(<\/?i>|<\/?p>|<p class=\".*>|<\/?b>|<\/?def>|<span class=\".*\">|<\/?math>|<\/?semantics>|<\/?mrow>|<\/?mi>|<\/?div .*><img src=.*>|<\/?figure .*>|<\/?annotation .*>)/m
        while @ingredient != ""
          @a_parts = @ingredient.partition(/(<span class=\"c_str_([^>]+)*>([^>]+)<\/span>|<!\-\-([^\-\->]+)*\-\->|<\/?([a-z]+)([^>]+)*(?:>))/)
          if @a_parts[0] == ""
            @cooked_str << @a_parts[1]
            @ingredient = @a_parts[2]
          else
            while @a_parts[0] != ""
              if (/[^A-Za-z0-9_,:;éîüåø\*\@\$\%\(\)\{\}\[\]]/.match(@a_parts[0].chr) == nil)
                @cooked_str << "<span class=\"c_str_" + @str_count.to_s + "\">" + @a_parts[0].chr + "</span>"
              else
                @cooked_str << @a_parts[0].chr
              end
              @a_parts[0][0] = ""
              @str_count = @str_count + 1
            end
            @cooked_str << @a_parts[1]
            @ingredient = @a_parts[2]
          end
        end
        @evangelist.paragraph1 = @cooked_str

        @cooked_str = ""
        @ingredient = @evangelist.extra #.gsub(/<span class=\"c_str_([^>]+)*>([^>])([^>]+)<\/span>/,'<span class="c_str_\1>\2</span>\3')

        while @ingredient != ""
          @a_parts = @ingredient.partition(/(<span class=\"c_str_([^>]+)*>(([^>]+)*)\/span>|<!\-\-([^\-\->]+)*\-\->|<\/?([a-z]+)([^>]+)*(?:>))/)
          if @a_parts[0] == ""
            @cooked_str << @a_parts[1]
            @ingredient = @a_parts[2]
          else
            while @a_parts[0] != ""
              if /[^A-Za-z0-9_,:;\*\@\$\%\(\)\{\}\[\]]/.match(@a_parts[0].chr) == nil
                @cooked_str << "<span class=\"c_str_" + @str_count.to_s + "\">" + @a_parts[0].chr + "</span>"
              else
                @cooked_str << @a_parts[0].chr
              end
              @a_parts[0][0] = ""
              @str_count = @str_count + 1
            end
            @cooked_str << @a_parts[1]
            @ingredient = @a_parts[2]
          end
        end
        @evangelist.extra = @cooked_str

        @evangelist.str_count = @str_count
        # replace end

        @evangelist.save!
        format.html { redirect_to @evangelist, notice: 'Nice edit' }
        format.json { render :show, status: :ok, location: @evangelist }
        format.js #render update.js
      else
        format.html { render :edit }
        format.json { render json: @evangelist.errors, status: :unprocessable_entity }
        format.js #render update.js
      end
    end
  end

  # DELETE /evangelists/1
  # DELETE /evangelists/1.json
  def destroy
    if current_user.id == 1 || (@evangelist.user == current_user && @evangelist.user.id != 4)
      @evangelist.destroy
    end

    respond_to do |format|
      format.html { redirect_to evangelists_url, notice: 'Into the thin air' }
      format.json { head :no_content }
    end
  end

  def rating
    #democratize
Evangelist.all.each do |evangelist|
denomi = ((DateTime.now.to_f - evangelist.created_at.to_f)/(60*60*30) + 2 )**1.2
nume = evangelist.likes_e + 2 + evangelist.views_e*0.01
evangelist.rating = nume/denomi
evangelist.save!
puts evangelist.rating
end

#democratize
Category.all.each do |category|
  i_a = category.users.size
  i_b = category.haters.size
  category.i_likes = i_a - i_b/10
    denomi = ((DateTime.now.to_f - category.created_at.to_f)/(60*60*40) + 10 )
    nume = category.i_likes + 2.0 + category.evangelists.size*0.05
    category.rating = nume/denomi
category.save!
end

  end

  private
  def recieve_yt
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_by(id: 4)
    end
    require 'open-uri'
    require 'addressable/uri'
    @yt_url = params['yt']

    # twitter
    if @yt_url.include?("youtu.be/")
      @yt_url["youtu.be/"] = "www.youtube.com/watch?v="
    end
    if @yt_url.include?("m.youtube")
      @yt_url["m.youtube.com/"] = "www.youtube.com/watch?v="
    end

    @yt_id = @yt_url.gsub(/[=&?]/, ' ').split(" ")[2]

    @evangelist = Evangelist.find_by(yt_id: @yt_id)
    if @evangelist != nil
      redirect_to @evangelist
    end

      @yt_img0 = "https://img.youtube.com/vi/" + @yt_id + "/mqdefault.jpg"
      @yt_img1 = "https://img.youtube.com/vi/" + @yt_id + "/1.jpg"
      @yt_img2 = "https://img.youtube.com/vi/" + @yt_id + "/2.jpg"
      @yt_img3 = "https://img.youtube.com/vi/" + @yt_id + "/3.jpg"

    begin
        html = open(Addressable::URI.parse(@yt_url.strip),
        :allow_redirections => :all,
        :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0.1) Gecko/20100101 Firefox/9.0.1") do |data|
          data.read
        end
    rescue => e
        puts "open uri error..."
        puts e.message
        puts ""
    end

    begin
        doc = Nokogiri::HTML.parse(html)
        @yt_title = doc.at_css("title").text
    rescue => e
        puts "Nokogiri error..."
        puts e.message
        puts ""
    end

    @yt_title.chop!.chop!.chop!.chop!.chop!.chop!.chop!.chop!.chop!.chop!

    puts "url..." + @yt_url
    puts "id..." + @yt_id
    gon.yt_url = @yt_url
    gon.yt_id = @yt_id
    gon.yt_title = @yt_title
    gon.yt_img0 = @yt_img0
    gon.yt_img1 = @yt_img1
    gon.yt_img2 = @yt_img2
    gon.yt_img3 = @yt_img3

  end
    # Use callbacks to share common setup or constraints between actions.
    def set_evangelist
      @evangelist = Evangelist.friendly.find(params[:title])
      @user_p = @evangelist.user
      @user = current_user
    end

    def next_video
      if user_signed_in?
        @user = current_user
        @goodtags = @user.categories
        @bantags = @user.hates
        @history = @user.history.uniq!
        @good_ids = Evangelist.joins(:categories).where('categories.id' => @goodtags).uniq.pluck(:id)
        @exclude_ids = Evangelist.joins(:categories).where('categories.id' => @bantags).uniq.pluck(:id)
      end

    if session[:history] == nil
      session[:history] = []
    end
    session[:history] << @evangelist.id
    if @user != nil
      @user.history << @evangelist.id
      @user.full_history.unshift(@evangelist.id)
      @user.full_history.uniq!
      if @user.full_history.size >= 50
        @user.full_history.pop
      end
      @user.save!
    end
      @categories = @evangelist.categories.limit(5)

      rating = @evangelist.rating

      #if user_signed_in?
      if user_signed_in?
         @next_e = Evangelist.joins(:categories).distinct.where('categories.id' => @categories).where(id: @good_ids).where.not(id: @exclude_ids).where.not(id: @history).where(rating: 0...rating).where.not(taglock: 2).order("rating DESC").paginate(:per_page => 6, :page => params[:page])
        if @next_e.size < 2
          @next_e =  Evangelist.joins(:categories).distinct.where('categories.id' => @categories).where.not(id: @exclude_ids).where.not(id: @history).where.not(taglock: 2).order("rating DESC").paginate(:per_page => 6, :page => params[:page])
          if @next_e.size < 2
            @next_e =  Evangelist.joins(:categories).distinct.where('categories.id' => @categories).where.not(id: @exclude_ids).where.not(taglock: 2).order("rating DESC").paginate(:per_page => 6, :page => params[:page])
            @user.history = []
            @user.save!
          end
        end

      else
        #not_signed_in
        @next_e = Evangelist.joins(:categories).distinct.where('categories.id' => @categories).where.not(id: session[:history]).where(rating: 0...rating).where.not(taglock: 2).order("rating DESC").paginate(:per_page => 6, :page => params[:page])
        if @next_e.size < 2
          @next_e = Evangelist.joins(:categories).distinct.where('categories.id' => @categories).where.not(taglock: 2).order("rating DESC").paginate(:per_page => 6, :page => params[:page])
          session[:history] = []
        end
      end
      @next_e_1 = @next_e.first
      if @next_e_1 == @evangelist
        @next_e_1 = @next_e.second
      end
      if @next_e_1 == nil
        @next_e_1 = @evangelist
      end
      #when playing playlist
      puts "start next video ..."
      if @user != nil

        @user.save!
      end
      @next_e_1_slug = @next_e_1.slug
      @repeat = 0

      if @next_e_1 == nil || @repeat == 1 || params['repeat'] == '1'
        @next_e_1 = @evangelist
        @next_e_1_slug = @next_e_1.slug + '?repeat=1'
        @repeat = 1
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evangelist_params
      params.require(:evangelist).permit(:extra,:image,:cover_e,:parent_id,:paragraph1,:evangelist_id, :yt_duration,:repeat,:title,:slug,:yt,:yt_id,:yt_img0,:yt_img1,:yt_img2,:yt_img3,:search, :post_short, :post,:prime_tag,:prime_tag_2,:r18,:taglock,:cate, :user_id, :demo_id,:tag_list,:video,:paragraph1,:all_categories,:category,:cate_send,:hennano, category_ids: [])
    end
end
