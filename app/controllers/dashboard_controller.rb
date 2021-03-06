class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @dashboard = DashboardPresenter.new(current_user)
  end

  class DashboardPresenter
    def initialize(user)
      @user = user
    end

    def entries
      @entries ||= Entry.joins(:schedule).merge(@user.schedules)
    end

    def entries_today
      entries.today
    end

    def entries_tomorrow
      entries.tomorrow
    end
  end
end
