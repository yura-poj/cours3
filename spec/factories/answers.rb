# frozen_string_literal: true

FactoryBot.define do
  sequence :body do |n|
    "Answer#{n}"
  end

  factory :answer, aliases: [:best_answer] do
    body
    question
    author

    trait :invalid do
      body { nil }
    end
  end
end
