class HomeController < ApplicationController

  before_filter :redirect_to_dashboard, if: :user_signed_in?

  def index
  end

  private

  def redirect_to_dashboard
    redirect_to dashboard_path
  end

end
