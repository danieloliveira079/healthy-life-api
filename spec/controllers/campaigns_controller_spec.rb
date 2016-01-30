require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

   before do
    user = User.create(email: "user@example.com", password: "password")
    authentication_token = AuthenticationToken.create(user_id: user.id,
      body: "token", last_used_at: DateTime.current)
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
   end

   it_behaves_like "api_controller"
   it_behaves_like "authenticated_api_controller"

   let(:valid_attributes) {
      { title: "Family Habits", active: true, description: "Get inspired by happy habits", interval: "00:30", category: "Family" }
    }

    let(:invalid_attributes) {
      { title: nil, active: true, description: "Get inspired by happy habits", interval: "00:30", category: "Family" }
    }

    let!(:campaign) { Campaign.create(valid_attributes) }

    describe "GET #index" do
      it "assigns all campaigns as @campaigns" do
        get :index, { format: :json }
        expect(assigns(:campaigns)).to eq([campaign])
      end
    end

    describe "GET #show" do
      it "assigns the requested campaign as @campaign" do
        get :show, { id: campaign.id, format: :json }
        expect(assigns(:campaign)).to eq(campaign)
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
           { title: "Family Habits", active: false, description: "Get inspired by happy habits", interval: "01:00", category: "Family" }
        end

        it "updates the requested campaign" do
          put :update, id: campaign.id, campaign: new_attributes, format: :json
          campaign.reload
          expect(campaign.active).to eq(false)
          expect(campaign.interval).to eq("01:00")
        end

        it "assigns the requested campaign as @campaign" do
          put :update, id: campaign.id, campaign: valid_attributes, format: :json
          expect(assigns(:campaign)).to eq(campaign)
        end
      end

      context "with invalid params" do
        it "assigns the campaign as @campaign" do
          put :update, id: campaign.id, campaign: invalid_attributes, format: :json
          expect(assigns(:campaign)).to eq(campaign)
        end

        it "returns unprocessable_entity status" do
          put :update, id: campaign.id, campaign: invalid_attributes, format: :json
          expect(response.status).to eq(422)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested campaign" do
        expect {
          delete :destroy, id: campaign.id, format: :json
       }.to change(Campaign, :count).by(-1)
      end

      it "redirects to the campaigns list" do
        delete :destroy, id: campaign.id, format: :json
        expect(response.status).to eq(204)
      end
    end

end
