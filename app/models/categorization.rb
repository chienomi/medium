class Categorization < ActiveRecord::Base
  belongs_to :evangelist
  belongs_to :category
end
