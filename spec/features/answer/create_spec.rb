# frozen_string_literal: true

require 'rails_helper'

feature 'User can create answer' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answers) { create_list(:answer, 2, question: question, author: user) }

  describe 'User create answer', js: true do
    scenario 'with errors' do
      sign_in(user)

      visit question_path(question)
      click_on 'Reply answer'
      click_on 'Reply'

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'with attached file' do
      sign_in(user)

      visit question_path(question)
      click_on 'Reply answer'
      fill_in 'Body', with: 'text text text'
      attach_file 'Files', [Rails.root.join('spec/rails_helper.rb'), Rails.root.join('spec/spec_helper.rb')]
      click_on 'Reply'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end
end
