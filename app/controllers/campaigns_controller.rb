class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :update, :destroy]

  def index
    @campaigns = current_user.campaign
    render json: @campaigns
  end

  def show
    @campaign = current_user.campaign.where(id: params[:id]).first
    render json: @campaign
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.user = current_user

    if @campaign.save
      render json: @campaign, status: :created, location: @campaign
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  def update
   if @campaign.update(campaign_params)
     head :no_content
   else
     render json: @campaign.errors, status: :unprocessable_entity
   end
 end

 def destroy
   @campaign.destroy

   head :no_content
 end

 private

    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:title, :active, :description, :interval, :category)
    end

end
