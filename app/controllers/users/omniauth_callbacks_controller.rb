module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def strava
      connect or signup
    end

    private

    def connect
      return false unless user_signed_in?

      oauth_account = current_user.oauth_accounts.from_omniauth(request.env["omniauth.auth"])

      if oauth_account.valid?
        set_flash_message(:notice, :success, kind: oauth_account.provider.titleize) if is_navigational_format?
        redirect_to dashboard_url
      else
        session["devise.strava_data"] = request.env["omniauth.auth"]
        redirect_to edit_user_registration_url, notice: "There was an error connecting with #{oauth_account.provider.titleize}"
      end
    end

    def signup
      raise "Not implemented"
    end
  end
end
