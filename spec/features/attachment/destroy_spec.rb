# frozen_string_literal: true

require 'rails_helper'

feature 'User can destroy file' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  background do
    sign_in(user)
  end

  scenario 'Author destroy file in question', js: true do
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
    click_on 'Ask'

    find_all('a', text: 'Delete file').first.click
    page.accept_alert

    expect(page).to_not have_link 'rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb'
  end

  scenario 'Author destroy file in answer', js: true do
    visit question_path(question)
    click_on 'Reply answer'
    fill_in 'Body', with: 'text text text'
    attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
    click_on 'Reply'

    find_all('a', text: 'Delete file').first.click
    page.accept_alert

    expect(page).to_not have_link 'rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb'
  end

end
