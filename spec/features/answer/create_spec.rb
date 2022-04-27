# frozen_string_literal: true

require 'rails_helper'

feature 'User can create answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answers) { create_list(:answer, 2, question: question, author: user) }

  background do
    sign_in(user)

    visit question_path(question)
  end

  scenario 'User create answer with errors', js: true do
    click_on 'Reply'
    expect(page).to have_content "Body can't be blank"
  end

end

