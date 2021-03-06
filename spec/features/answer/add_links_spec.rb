# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to answer', "
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:right_url) { 'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c' }

  scenario 'User adds link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    click_on 'Reply answer'

    fill_in 'Body', with: 'My answer'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: right_url

    click_on 'Reply'

    within '.answers' do
      expect(page).to have_link 'My gist', href: right_url
    end
  end
end
