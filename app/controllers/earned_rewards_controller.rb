# frozen_string_literal: true

class EarnedRewardsController < ApplicationController
  def index
    @rewards = current_user.rewards
  end
end
