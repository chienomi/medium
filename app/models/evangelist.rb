class Evangelist < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :likes
  # belongs_to :demo
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :conversations, -> {order(:time)}, dependent: :destroy
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations, dependent: :destroy
  has_many :playlists, through: :likes

  has_many :uploads, dependent: :destroy
  def normalize_friendly_id(string)
    # この場合 string は name
    #change title
    string.gsub(/[\.\s\/,\.\\\*\+\?\{\}\(\)\[\]\^\$\?\|\":;\']/, "")
  end

  def no_ps(string)
    string.title.gsub!(/\<div class=\"medium-insert-buttons\".*div\>/," ").gsub!(/(<p>|<\/p>)/," ").strip
  end

  def self.search(search)
  	where("title ILIKE ?", "%#{search}%")
  end

  	def all_categories=(names)
  		# replace white space
  		self.prime_tag.gsub!(/\s/," ")
  		self.prime_tag.gsub!(/\s/," ")
  		new_names = self.prime_tag + " " + names
  		flag = 0
  		while flag == 0 do
	  		if new_names.include?("　")
	    		new_names["　"] = " "
	    	end
	    	if !new_names.include?("　")
	    		flag = 1
	    	end
    	end
  		new_names = new_names.split(" ")
      if new_names != nil || new_names != [] || new_names != [""]|| new_names != [" "]
        new_names = new_names.uniq
      end

  		if new_names != nil
  		self.categories = new_names.map do |name|
  			Category.where(name: name.strip).first_or_create!

  		end
  		end
  	end

  	def all_categories
  		self.categories.map(&:name).join(" ")
  	end

	def self.category_of(name)
	  Category.find_by_name!(name).evangelists
	end

	def self.tag_counts
	  Category.select("categories.*, count(categorizations.category_id) as count").
	  joins(:categorizations).group("categorizations.category_id")
	end

	def tag_list
	  categories.map(&:name).join(", ")
	end

	def tag_list=(names)
	  self.categories = names.split(" ").map do |n|
	    Category.where(name: n.strip).first_or_create!
	  end
	end

  validates :title, presence: true, length: {minimum:1},uniqueness: true
  validates :title_s, presence: false, length: {maximum: 20, allow_nil: true}
	validates :post_short, length: {minimum:4, maximum: 200 , allow_nil: true}
	validates :tag_list, presence: false, length: { maximum: 50 }


def self.rating
ActiveRecord::Base.record_timestamps = false
#democratize
Evangelist.all.each do |evangelist|
denomi = ((DateTime.now.to_f - evangelist.created_at.to_f)/(60*60*30) + 2 )**1.2
nume = evangelist.likes_e + 2 + evangelist.views_e*0.01 + evangelist.come_e*0.05
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
puts category.rating
end

ActiveRecord::Base.record_timestamps = true
end

  extend FriendlyId
  friendly_id :title, use: [:slugged]

end
