# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'
  has_many_attached :files

  validates :body, presence: true

  def author?(user)
    author == user
  end
end
