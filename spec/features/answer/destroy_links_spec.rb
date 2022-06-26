# frozen_string_literal: true

require 'rails_helper'

feature 'User can destroy links from question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }
  given!(:link) { create(:link, linkable: answer) }

  scenario 'User destroy link successfully', js: true do
    sign_in(user)
    visit question_path(question)
    find_all('a', text: 'Delete link').first.click
    page.accept_alert

    expect(page).to_not have_link link.name, href: link.url
  end
end
