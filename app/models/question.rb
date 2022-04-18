# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers

  validates :title, :body, presence: true
end
