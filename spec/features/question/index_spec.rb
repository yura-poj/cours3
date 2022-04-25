# frozen_string_literal: true

require 'rails_helper'

feature 'User can watch list of questions', "
  In order to get answer from a community
  As an unauthenticated user
  I'd like to be able to watch questions
" do
  given!(:questions) { create_list(:question, 2) }

  background { visit questions_path }

  scenario 'User watch questions' do
    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.second.title
  end
end
