# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign out', "
  In order to change account
  As an authenticated user
  I'd like to be able to sign out
" do
  given(:user) { create(:user) }

  background { sign_in(user) }

  scenario 'Authenticated user tries to sign out' do
    visit questions_path
    click_on('Logout')

    expect(page).to have_content 'Signed out successfully.'
  end
end
