# frozen_string_literal: true

class EarnedReward < ApplicationRecord
  belongs_to :user
  belongs_to :reward
end
