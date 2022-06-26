# frozen_string_literal: true

class Reward < ApplicationRecord
  belongs_to :question
  has_one_attached :image
  has_many :earned_rewards
  has_many :users, through: :earned_rewards

  validates :title, presence: true
end
