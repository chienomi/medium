module ApplicationHelper
  require 'open-uri'
  # require 'open_uri_redirections'
  require 'addressable/uri'
    def spider()
    @page_urls = []
    # set url
    # urls_i = ["https://www.reddit.com/r/technews/"]
    # urls_i << "http://www.technewsworld.com/"
    # urls_i << "http://www.cnet.com/news/"
    # urls_i << "http://www.wired.co.uk/news"
    # urls_i << "http://www.wired.com/latest-news/"
    # urls_i << "http://www.bbc.com/news/technology"
    # urls_i << "http://www.pcmag.com/news"
    # urls_i << "http://www.news.com.au/technology"
    # urls_i << "http://www.gizmag.com/"
    # urls_i << "http://timesofindia.indiatimes.com/tech"
    # urls_i << "http://www.livescience.com/technology/"
    # urls_i << "http://www.reuters.com/news/technology"
    # urls_i << "http://www.pcworld.com/category/tech-events-dupe/"
    # urls_i << "http://www.forbes.com/technology/"
    # urls_i << "http://gadgets.ndtv.com/news"
    # urls_i << "https://www.newscientist.com/subject/technology/"
    # urls_i << "http://phys.org/technology-news/"
    # urls_i << "http://www.techradar.com/news/world-of-tech"
    # urls_i << "http://www.zdnet.com/"
    # urls_i << "http://www.nytimes.com/pages/technology/index.html"
    # urls_i << "http://www.designbolts.com/"
    # urls_i << "http://metro.co.uk/news/tech/"
    # urls_i << "http://www.popsci.com/"
    # urls_i << "http://news.discovery.com/tech/tags/latest-cool-gadgets.htm"
    # urls_i << "http://www.techinsider.io/"
    # urls_i << "http://www.geek.com/"
    urls_i = ["https://news.ycombinator.com/show"]

    url = urls_i.first

    urls = [url] # stack of urls to scrape
    visited = [url]

    while urls.length > 0
      flag = 1
      begin
        html = open(Addressable::URI.parse(urls.last.strip),
        :allow_redirections => :all,
        :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0.1) Gecko/20100101 Firefox/9.0.1") do |data|
          data.read
        end
      rescue => e
        puts "open uri error..."
        puts e.message
        puts ""
        urls.pop
        next
      end

      begin
        doc = Nokogiri::HTML.parse(html)
        @title = doc.at_css("title").text
        @body = doc.at_css("body").text.strip
        urls.pop
        puts urls.length

        #find
        doc.css("a").each do |item|
          @href = item[:href]
          if (/^http.*[^&?=].*/ =~ @href) #new
             if !@href.in?(visited)
              if !@href.in?(urls) & flag == 1
                urls << @href
              end
              visited << @href
              puts @href
            end
          end
        end
        flag = 0

      rescue => e
        puts "Nokogiri error..."
        puts e.message
        puts ""
        urls.pop
        next
      end
    end
  end

  def search_HN()
      urls_i = ["https://news.ycombinator.com/show"]
      url = urls_i.first
      urls = [url] # stack of urls to scrape
      visited = [url]
      while urls.length > 0
        flag = 1
        begin
          html = open(Addressable::URI.parse(urls.last.strip),
          :allow_redirections => :all,
          :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0.1) Gecko/20100101 Firefox/9.0.1") do |data|
            data.read
          end
        rescue => e
          puts "open uri error..."
          puts e.message
          puts ""
          urls.pop
          next
        end

        begin
          doc = Nokogiri::HTML.parse(html)
          doc.css(".athing").each do |post|
            post.css('.title a').text
          end
          doc.css(".athing .title a").first.text
          @title = doc.at_css("title").text
          @body = doc.at_css("body").text.strip
          urls.pop
          puts urls.length

          #find
          doc.css("a").each do |item|
            @href = item[:href]
            if (/^http.*[^&?=].*/ =~ @href) #new
               if !@href.in?(visited)
                if !@href.in?(urls) & flag == 1
                  urls << @href
                end
                visited << @href
                puts @href
              end
            end
          end
          flag = 0

        rescue => e
          puts "Nokogiri error..."
          puts e.message
          puts ""
          urls.pop
          next
        end
      end

  end


    def resource_name
    	:user
    end

    def resource
    	@resource ||= User.new
    end

  	def devise_mapping
    	@devise_mapping ||= Devise.mappings[:user]
  	end

    def is_noun?(word)
      w = Word.find_by(name: word)
      w.parent.any? { |w| w.in?() }
    end

    def max_feel(word)
      word_w = Word.find_by(name: word)
      if word_w != nil
        word_rel_a = Word.where(relation: word_w)
      end
    end

    def max_cor(array)
      if array != []
        max = array[0][1]
        max_iter = array.size - 1
        (0..max_iter).each do |iter|
          if max < array[iter][1]
            max = array[iter][1]
          end
        end
      end
      if max != nil
        max
      end
    end
  	# class HTMLwithPygments < Redcarpet::Render::HTML
  	# 	def block_code(code, language)
  	# 		Pygments.highlight(code, lexer: language)
  	# 	end
  	# end

  	# def markdown(text)
  	# 	renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
  	# 	options = {
  	# 		autolink: true,
  	# 		no_intra_emphasis: true,
  	# 		fenced_code_blocks: true,
  	# 		lax_html_blocks: true,
  	# 		strikethrough: true,
  	# 		superscript:true
  	# 	}
  	# 	Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  	# end
end
