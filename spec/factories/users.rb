# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user, aliases: [:author] do
    email
    password { '12345678' }
    password_confirmation { '12345678' }
    confirmed_at { 1.minute.ago }
  end
end
