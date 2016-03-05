class Image < ActiveRecord::Base
  validates_presence_of :path, :campaign

  belongs_to :campaign
end
