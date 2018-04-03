class Comment < ActiveRecord::Base
  belongs_to :demo

  acts_as_tree order: 'created_at DESC'
end
