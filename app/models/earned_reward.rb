class EarnedReward < ApplicationRecord
  belongs_to :answer
  belongs_to :reward
end
