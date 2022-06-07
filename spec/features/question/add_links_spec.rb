# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given(:right_url) { 'https://stackoverflow.com/questions/3089849/ruby-on-rails-submitting-an-array-in-a-form' }
  given(:wrong_url) { 'https://stacko' }

  describe 'User adds link', js: true do
    background do
      sign_in(user)
      visit questions_path

      click_on 'Ask question'

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      fill_in ' Name', with: 'My url'
    end


    scenario 'without errors' do
      fill_in ' Url', with: right_url

      click_on 'Ask'

      expect(page).to have_link 'My url', href: right_url
    end

    scenario 'with errors' do
      fill_in ' Url', with: wrong_url

      click_on 'Ask'

      expect(page).to have_content 'Links url is not valid'
    end
  end
end
