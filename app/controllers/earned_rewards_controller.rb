# frozen_string_literal: true

class EarnedRewardsController < ApplicationController
  authorize_resource

  def index
    @rewards = current_user.rewards
  end
end
