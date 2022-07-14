# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_authorization_check
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    # You should also create an action method in this controller like this:
    def google_oauth2
      handle_auth 'Google'
    end

    def github
      handle_auth 'Github'
    end

    def handle_auth(kind)
      user = FromOmniauthService.new(request.env['omniauth.auth']).call

      if user.present?
        sign_out_all_scopes
        set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
        sign_in_and_redirect user, event: :authentication
      else
        flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: kind, reason: 'email is not authorized.'
        redirect_to new_user_session_path
      end
    end

    # More info at:
    # https://github.com/heartcombo/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end
  end
end
