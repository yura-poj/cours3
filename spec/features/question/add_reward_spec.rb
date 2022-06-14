# frozen_string_literal: true

require 'rails_helper'

feature 'User can add reward to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add reward
" do
  given(:user) { create(:user) }

  describe 'User adds reward', js: true do
    background do
      sign_in(user)
      visit questions_path

      click_on 'Ask question'

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

    end

    scenario 'without errors' do
      text = 'Some'
      fill_in ' Title', with: text
      click_on 'Ask'
      click_on 'Test question'

      expect(page).to have_content text
    end
  end
end

