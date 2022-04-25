# frozen_string_literal: true

FactoryBot.define do
  sequence :body do |n|
    "Answer#{n}"
  end

  factory :answer do
    body
    question
    author { create(:user) }

    trait :invalid do
      body { nil }
    end
  end
end
