# frozen_string_literal: true

class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.with_valid_votes
  end

  def show
    @campaign = Campaign.find params[:id]
  end
end
