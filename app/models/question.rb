# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'
  has_many_attached :files
  has_many :links, dependent: :destroy, as: :linkable
  has_one :reward, dependent: :destroy
  belongs_to :best_answer, class_name: 'Answer', optional: true

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :reward, reject_if: :all_blank

  validates :title, :body, presence: true
  validates :title, uniqueness: true

  def author?(user)
    author == user
  end

  def set_best_answer(answer)
    return nil unless related?(answer)

    previous_answer = best_answer
    self.best_answer = answer
    answer.author.rewards.push(reward) if reward && !answer.author.has_reward?(reward)
    save!

    previous_answer
  end

  private

  def related?(obj)
    self == obj.question
  end
end
