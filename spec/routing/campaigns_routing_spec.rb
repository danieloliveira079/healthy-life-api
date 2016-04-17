require 'rails_helper'

RSpec.describe CampaignsController, type: :routing do
  it { expect(get:    "/campaigns").to   route_to("campaigns#index") }
  it { expect(get:    "/campaigns/1").to route_to("campaigns#show", id: "1") }
  it { expect(post:   "/campaigns").to   route_to("campaigns#create") }
  it { expect(put:    "/campaigns/1").to route_to("campaigns#update", id: "1") }
  it { expect(delete: "/campaigns/1").to route_to("campaigns#destroy", id: "1") }
  it { expect(get:    "/viewcampaigns").to   route_to("campaigns#viewcampaigns") }
end
