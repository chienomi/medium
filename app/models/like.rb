class Like < ActiveRecord::Base
  belongs_to :evangelist
  belongs_to :user
  belongs_to :playlist
end
