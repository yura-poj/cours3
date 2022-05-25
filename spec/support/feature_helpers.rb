# frozen_string_literal: true

module FeatureHelpers
  def sign_in(user)
    # visit new_user_session_path
    #
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: user.password
    # click_on 'Log in'
    login_as(user, scope: :user)
  end
end
