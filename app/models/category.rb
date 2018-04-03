class Category < ActiveRecord::Base
	has_many :categorizations, dependent: :destroy
	has_many :ucategorizations, dependent: :destroy
	has_many :bantags
	has_many :evangelists, through: :categorizations
	has_many :users, through: :ucategorizations
	has_many :haters, through: :bantags, source: :user
	validates :name, presence: true, uniqueness: true

  def self.search(search)
  	where("name ILIKE ?", "%#{search}%")
  end

end