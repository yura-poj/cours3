# frozen_string_literal: true

class User < ApplicationRecord
  has_many :earned_rewards
  has_many :rewards, through: :earned_rewards
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
