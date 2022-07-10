# frozen_string_literal: true

class User < ApplicationRecord
  has_many :earned_rewards
  has_many :rewards, through: :earned_rewards
  has_many :authorizations, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :confirmable,
         omniauth_providers: [:github, :google_oauth2]


  def has_reward?(reward)
    rewards.include?(reward)
  end

end
