class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :evangelist

  acts_as_tree order: 'created_at DESC'
end
