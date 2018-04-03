class Demo < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy, foreign_key: 'demo_id'
	has_many :funds, dependent: :destroy, foreign_key: 'demo_id'
	has_many :funs, through: :funds, source: :user, foreign_key: 'demo_id'
	has_many :evas, through: :evangelists, source: :user, foreign_key: 'demo_id'
	has_many :evangelists, foreign_key: 'demo_id'


end
