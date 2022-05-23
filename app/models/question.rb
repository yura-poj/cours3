# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true
  validates :title, uniqueness: true

  def author?(user)
    author == user
  end
end
