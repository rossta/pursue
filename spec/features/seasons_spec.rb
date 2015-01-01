require 'rails_helper'

RSpec.feature 'Seasons', :pending do
  let(:user) { create(:user) }

  scenario "Start new season from dashboard" do
    create(:event, :upcoming, title: "Ironman 70.3 Mont-Tremblant")
    create(:training_plan, :for_half_ironman, title: "Half-Ironman 1")
    create(:training_plan, :for_half_ironman, title: "Half-Ironman 2")

    login_as user

    visit dashboard_path

    click_link "Start new season"

    # seasons/new
    fill_form :main_event, {
      "What's your main event?" => "Ironman 70.3 Mont-Tremblant"
    }

    fill_form :training_plan, {
      "Choose a training plan" => "Half-Ironman 1"
    }

    click_button "Go"

    expect(page).to have_content("Your Upcoming Events")
    expect(page).to have_content("Mont-Tremblant")
    expect(page).to have_content("Half-Ironman 1")
  end

  scenario "Season detail page diplays default training blocks" do
    season = create(:season, :with_main_event, user: user)
    season.prepare!

    login_as user

    visit season_path(season)

    expect(page).to have_content("Your Training Schedule")

    %w( Prep Base Build Peak Race Transition ).each do |block_name|
      expect(page).to have_content(block_name)
    end
  end

  scenario "Season detail page displays weekly breakdown based on A-race" do
    main_event = create(:event, :upcoming, occurs_on: 7.months.from_now)

    season = create(:season, main_event: main_event, user: user)
    season.prepare!

    login_as user

    visit season_path(season)

    season.duration.each do |week|
      expect(page).to have_content("Week #{week}")
    end
  end
end
