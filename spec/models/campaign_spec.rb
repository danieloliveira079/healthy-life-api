require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe "db structure" do
   it { is_expected.to have_db_column(:title).of_type(:string) }
   it { is_expected.to have_db_column(:active).of_type(:boolean) }
   it { is_expected.to have_db_column(:description).of_type(:text) }
   it { is_expected.to have_db_column(:interval).of_type(:string) }
   it { is_expected.to have_db_column(:category).of_type(:string) }
   it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
   it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }

 end

 describe "associations" do
   it { is_expected.to belong_to(:user) }
   it { is_expected.to have_many(:image) }
 end

 describe "validations" do
   it { is_expected.to validate_presence_of(:title) }
   it { is_expected.to validate_presence_of(:description) }
   it { is_expected.to validate_presence_of(:interval) }
   it { is_expected.to validate_presence_of(:category) }
   it { is_expected.to validate_presence_of(:user) }
 end
end
