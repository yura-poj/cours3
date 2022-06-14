# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    url { 'https://stackoverflow.com' }
    name { 'MyString' }
    linkable { question }
  end
end
