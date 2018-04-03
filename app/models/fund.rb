class Fund < ActiveRecord::Base
  belongs_to :demo
  belongs_to :user
end
