class LikesController < ApplicationController
	before_filter :authenticate_user!
	before_action :find_evangelist
	before_action :find_evangelists
	def create
        @user = current_user

		# rating

        if user_signed_in?
            if !@user.likes.find_by(evangelist_id: @evangelist.id)
            @evangelist.likes.create(user: current_user)
            @evangelist.likes_e = @evangelist.likes_e + 1
            # denomi = ((DateTime.now.to_f - @evangelist.created_at.to_f)/(60*60*30) + 2 )**1.2
            # nume = (@evangelist.likes_e + 2 + @evangelist.views_e*0.01)
            # @evangelist.rating = nume/denomi
            @evangelist.save
            end
        end

    	if params['formating'] == 'user'
    		render "create_u.js"
    	elsif params['formating'] == 'show'
    		if user_signed_in?
      			@current_like = @user.likes.find_by(evangelist_id: @evangelist.id)
    		end
    		render "create_s.js"
    	else
    		render "create.js"
    	end
	end

	def destroy
		@like = Like.find(params[:id])
		@like.destroy

		# rating

        if user_signed_in?
            @evangelist.likes_e = @evangelist.likes_e - 1
        # denomi = ((DateTime.now.to_f - @evangelist.created_at.to_f)/(60*60*30) + 2 )**1.2
        # nume = (@evangelist.likes_e + 2 + @evangelist.views_e*0.01)
        # @evangelist.rating = nume/denomi
        @evangelist.save!
        end

		if params['formating'] == 'user'
    		render "create_u.js"
    	elsif params['formating'] == 'show'
    		if user_signed_in?
      			@current_like = @user.likes.find_by(evangelist_id: @evangelist.id)
    		end
    		render "create_s.js"
    	else
    		render "create.js"
    	end
	end

    def add_list
        @user = current_user

        # rating
        if user_signed_in?
            if @user.likes.find_by(evangelist_id: @evangelist.id)
                @plist = @user.likes.find_by(evangelist_id: @evangelist.id)
                @plist.playlist_num = params[:play_n]
                @plist.save
            end
        end

        if params['formating'] == 'user'
            render "create_u.js"
        elsif params['formating'] == 'show'
            if user_signed_in?
                @current_like = @user.likes.find_by(evangelist_id: @evangelist.id)
            end
            render "create_s.js"
        else
            render "create.js"
        end
    end

	private
	def like_params
      params.require(:like).permit(:formating,:evangelist_title,:title,:category,:playorder,:playlist_num,:play_n,:play_o)
	end
	def find_evangelist
		@evangelist = Evangelist.friendly.find(params[:evangelist_title])
	end
	def find_evangelists
       @user = current_user
        @categories_topic = Category.order("rating DESC").limit(6)

      if params[:category]
        @evangelists_topic = Evangelist.category_of(params[:category]).order("rating DESC").paginate(:per_page => 12, :page => params[:page])
        @search_index = params[:category]
        # @categories = Category.joins(:ucategorizations).where('ucategorizations.user_id' => @user).order("rating DESC")


      elsif @user != nil && @user.ucategorizations.first != nil
        @bantags = @user.hates
        @evangelists_topic = Evangelist.joins(:categories).distinct.where.not('categories.id' => @bantags).order("rating DESC").paginate(:per_page => 12, :page => params[:page])
        @categories = Category.joins(:ucategorizations).where('ucategorizations.user_id' => @user).order("rating DESC")
        @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @categories).order("rating DESC").paginate(:per_page => 5, :page => params[:page])
        @evangelists_okini_news = @evangelists
      else
        @evangelists_topic = Evangelist.order("rating DESC").paginate(:per_page => 12, :page => params[:page])
        @evangelists = @evangelists = Evangelist.order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
        @evangelists_okini_news = @evangelists
        @categories = Category.order("rating DESC").limit(5)
      end


	   # @user = current_user
    #   if params[:category]
    #     @evangelists = Evangelist.category_of(params[:category]).order("rating DESC").paginate(:per_page => 12, :page => params[:page])
    #     @categories = Category.joins(:ucategorizations).where('ucategorizations.user_id' => @user).order("rating DESC")

    #     c_cate = Category.find_by(name: params[:category])
    #     if !@categories.include?(c_cate)
    #     	@categories << c_cate
    #     end

    #   elsif @user != nil && @user.ucategorizations.first != nil
    #   	@liked_evangelists = @user.liked_evangelists
    #     @categories = Category.joins(:ucategorizations).where('ucategorizations.user_id' => @user).order("rating DESC")
    #     @evangelists = Evangelist.joins(:categories).distinct.where('categories.id' => @categories).order("rating DESC").paginate(:per_page => 12, :page => params[:page])
    #   else
    #     @evangelists = Evangelist.category_of("アニソン").order("rating DESC").paginate(:per_page => 10, :page => params[:page])
    #     @categories = Category.where(name: 'アニソン')
    #   end

	end
end
