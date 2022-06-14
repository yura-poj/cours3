# frozen_string_literal: true

require 'rails_helper'

feature 'User can watch question with answers', "
  In order to watch answer from a community
  As an unauthenticated user
  I'd like to be able to watch answers on question
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answers) { create_list(:answer, 2, question: question, author: user) }

  describe 'Unauthenticated user' do
    background do
      visit questions_path
      click_on question.title
    end

    scenario 'User watch question' do
      expect(page).to have_content question.title
      expect(page).to have_content answers.first.body
      expect(page).to have_content answers.second.body
    end
  end

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)

      visit questions_path
      click_on question.title
    end

    scenario 'create answer' do
      click_on 'Reply answer'
      text = 'test text'
      fill_in 'Body', with: text
      click_on 'Reply'

      expect(page).to have_content text
      expect(page).to have_content 'Successfully created'
    end

    scenario 'author delete question' do
      click_on 'Delete question'

      expect(page).to_not have_content question.body
    end

    scenario 'author delete answer' do
      find_all('a', text: 'Delete answer').first.click

      expect(page).to_not have_content answers.first.body
    end
  end
end
