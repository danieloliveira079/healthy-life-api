class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :title, :active, :description, :interval, :category, :image
end
