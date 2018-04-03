module EvangelistsHelper
  def comments_tree_for(comments)
    comments.map do |comment, nested_comments|
      render(comment) +
          (nested_comments.size > 0 ? content_tag(:div, comments_tree_for(nested_comments), class: "replies") : nil)
    end.join.html_safe
  end

	def category_links(categories)
		categories.split(" ").map{|c| link_to c.strip, category_path(c.strip)}.join(" ")
	end

	def i_subscriber(t)
		t1 = Category.find_by(name: t)
		t1.users.size
	end

	def i_video_num(t)
		t1 = Category.find_by(name: t)
		if t1 != nil
			t1.evangelists.size
		else
			"?"
		end
	end

	def evas_of(t)
		if @elimi_prev == nil
			@elimi_prev = []
		end
		t = Category.find_by(name: t)
		Evangelist.joins(:categories).distinct.where('categories.id' => t).distinct.where.not(id: @exclude_ids).where.not(taglock: 2).where.not(id: @elimi_prev).order("rating DESC").limit(8)

	end

	def user_categorize?(t)
		if user_signed_in?
			t2 = Category.find_by(name: t)
			current_user.in?(t2.users)
		end
	end
	def user_ban?(t)
		if user_signed_in?
			t2 = Category.find_by(name: t)
			current_user.in?(t2.haters)
		end
	end

	def cate_id(t)
		if user_signed_in?
			t3 = Category.find_by(name: t)
			current_user.ucategorizations.find_by(category_id: t3.id)
		end
	end
	def ban_id(t)
		if user_signed_in?
			t3 = Category.find_by(name: t)
			current_user.bantags.find_by(category_id: t3.id)
		end
	end

	def current_like_of(evangelist)
		current_user.likes.find_by(evangelist_id: evangelist.id)
	end

	def playlist_name(p)
		p.evangelists.each do |e|
			e.title
		end
	end
end
