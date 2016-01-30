class Campaign < ActiveRecord::Base
  validates_presence_of :title, :description, :interval, :category
  validates_inclusion_of :active, in: [true, false]
end
