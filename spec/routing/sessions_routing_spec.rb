require 'rails_helper'

RSpec.describe SessionsController, type: :routing do
  it { expect(post:   "/sessions").to route_to("sessions#create") }
  it { expect(delete: "/sessions").to route_to("sessions#destroy") }
  it { expect(post: "/signup").to route_to("sessions#signup") }
  it { expect(post: "/recovery").to route_to("sessions#recovery") }
end
