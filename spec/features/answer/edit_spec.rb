# frozen_string_literal: true

require 'rails_helper'

feature 'User can create answer', "
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unauthenticated user can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Auth user', js: true do
    scenario 'edits his answer' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'

      text = 'edited answer'

      fill_in 'Body', with: text
      click_on 'Reply'

      expect(page).to_not have_selector 'textarea'
      expect(page).to_not have_content answer.body
      expect(page).to have_content text
    end
  end
end
