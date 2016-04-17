require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

   let(:valid_attributes_with_user) {
      {
         user_id: user.id,
         title: "Family Habits",
         active: true,
         description: "Get inspired by happy habits",
         interval: "00:30",
         category: "Family",
         image: []
      }
   }

   let!(:user) { User.create(email: "user1@example.com", password: "password") }
   let!(:campaign_with_user) {
      c = Campaign.create(valid_attributes_with_user)
   }
   let(:user_campaigns){ user.campaign }

   describe "GET #viewcampaigns" do
      it "assigns all campaigns as @campaigns" do
        get :viewcampaigns, { format: :json }
        expect(assigns(:campaigns)).to eq(user_campaigns)
      end
    end

end

RSpec.describe CampaignsController, type: :controller do

   it_behaves_like "api_controller"
   it_behaves_like "authenticated_api_controller"

   let!(:user) { User.create(email: "user1@example.com", password: "password") }
   let!(:campaign_with_user) {
      c = Campaign.create(valid_attributes_with_user)
   }

   let(:image_with_campaign) {
      i = Image.create({ path: '/temp/oldImage.png', campaign_id: campaign_with_user.id })
   }

   let(:user_campaigns){ user.campaign }

   let(:valid_attributes) {
      {
         title: "Family Habits",
         active: true,
         description: "Get inspired by happy habits",
         interval: "00:30",
         category: "Family",
         image: []
       }
   }

   let(:valid_attributes_with_user) {
      {
         user_id: user.id,
         title: "Family Habits",
         active: true,
         description: "Get inspired by happy habits",
         interval: "00:30",
         category: "Family",
         image: []
      }
   }

   let(:invalid_attributes) {
      {
         title: nil,
         active: true,
         description: "Get inspired by happy habits",
         interval: "00:30",
         category: "Family",
         image: []
      }
   }

   let(:campaign_with_image) {
      {  title: "Family Habits",
         active: true,
         description: "Get inspired by happy habits",
         interval: "00:30",
         category: "Family",
         image: [
            { path: '/temp/test.png' },
            { path: '/temp/test2.png' }
         ]
      }
   }

   before do
     authentication_token = AuthenticationToken.create(user_id: user.id,
       body: "token", last_used_at: DateTime.current)
       request.env["HTTP_X_USER_EMAIL"] = user.email
       request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
   end

   describe "GET #index" do
      it "assigns all campaigns as @campaigns" do
        get :index, { format: :json }
        expect(assigns(:campaigns)).to eq(user_campaigns)
      end
    end

    describe "GET #show" do
      it "assigns the requested campaign as @campaign" do
        get :show, { id: campaign_with_user.id, format: :json }
        expect(assigns(:campaign)).to eq(campaign_with_user)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Campaign" do
          expect {
            post :create, { campaign: valid_attributes, format: :json  }
         }.to change(Campaign, :count).by(1)
        end

        it "assigns a newly created campaign as @campaign" do
          post :create, { campaign: valid_attributes, format: :json  }
          expect(assigns(:campaign)).to be_a(Campaign)
          expect(assigns(:campaign)).to be_persisted
        end

        it "creates a new Campaign with image" do
           expect {
            post :create, { campaign: campaign_with_image, format: :json  }
         }.to change(Image, :count).by(2)
        end

      end

      context "with invalid params" do
        it "assigns a newly created but unsaved campaign as @campaign" do
          post :create, { campaign: invalid_attributes, format: :json  }
          expect(assigns(:campaign)).to be_a_new(Campaign)
        end

        it "returns unprocessable_entity status" do
          put :create, { campaign: invalid_attributes }
          expect(response.status).to eq(422)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) do
           {
             title: "Family Habits",
             active: false,
             description: "Get inspired by happy habits",
             interval: "01:00",
             category: "Family",
             image: [ path: '/temp/newTest.png']
          }
        end

        it "updates the requested campaign" do
          put :update, id: campaign_with_user.id, campaign: new_attributes, format: :json
          campaign_with_user.reload
          expect(campaign_with_user.active).to eq(false)
          expect(campaign_with_user.interval).to eq("01:00")
        end

        it "assigns the requested campaign as @campaign" do
          put :update, id: campaign_with_user.id, campaign: valid_attributes, format: :json
          expect(assigns(:campaign)).to eq(campaign_with_user)
        end

        it "updates the requested campaign images" do
           put :update, id: campaign_with_user.id, campaign: new_attributes, format: :json
           campaign_with_user.reload
           expect(campaign_with_user.image.count).to eq(1)
        end

      end

      context "with invalid params" do
        it "assigns the campaign as @campaign" do
          put :update, id: campaign_with_user.id, campaign: invalid_attributes, format: :json
          expect(assigns(:campaign)).to eq(campaign_with_user)
        end

        it "returns unprocessable_entity status" do
          put :update, id: campaign_with_user.id, campaign: invalid_attributes, format: :json
          expect(response.status).to eq(422)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested campaign" do
        expect {
          delete :destroy, id: campaign_with_user.id, format: :json
       }.to change(Campaign, :count).by(-1)
      end

      it "destroys the referenced images" do
         id = image_with_campaign.id
         delete :destroy, id: campaign_with_user.id, format: :json
         expect(campaign_with_user.image.count).to eq(0)
      end

      it "redirects to the campaigns list" do
        delete :destroy, id: campaign_with_user.id, format: :json
        expect(response.status).to eq(204)
      end
    end

end
