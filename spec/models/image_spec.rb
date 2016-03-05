require 'rails_helper'

RSpec.describe Image, type: :model do
  describe "db structure" do
    it { is_expected.to have_db_column(:path).of_type(:string) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:campaign) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:path) }
  end
end
