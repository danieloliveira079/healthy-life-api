class Campaign < ActiveRecord::Base
  validates_presence_of :title, :description, :interval, :category, :user
  validates_inclusion_of :active, in: [true, false]

  belongs_to :user
  has_many :image, :dependent => :destroy
end
