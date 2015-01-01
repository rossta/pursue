require 'rails_helper'

RSpec.describe 'Schedules' do

  context 'Athletes' do
    let(:athlete) { create(:user) }

    scenario 'choose a training plan' do
      date = 7.months.from_now.end_of_week.to_date

      create(:training_plan, title: "Your Best Half Ironman", total_weeks: 10, peak_week: 8)
      create(:event, title: "Ironman 70.3 Mont-Tremblant", occurs_on: date)

      login_as athlete

      visit dashboard_path

      click_link "Start training"

      fill_form :schedule, {
        "What are you training for?" => "Ironman 70.3 Mont-Tremblant",
        "Choose a training plan" => "Your Best Half Ironman"
      }

      click_button "Go"

      expect(page).to have_content("Schedule")
      expect(page).to have_content("Your Best Half Ironman")
      expect(page).to have_content("Ironman 70.3 Mont-Tremblant")

      peaks_on = date
      expect(page).to have_content("Peaks on")
      expect(page).to have_content(I18n.l(peaks_on, format: :short))

      starts_on = date - 8.weeks + 1.day
      expect(page).to have_content("Starts on")
      expect(page).to have_content(I18n.l(starts_on, format: :short))

      ends_on = date + 2.weeks
      expect(page).to have_content("Ends on")
      expect(page).to have_content(I18n.l(ends_on, format: :short))

      (1..10).each do |week|
        within(".week_#{week}") do
          expect(page).to have_content("Week #{week}")

          week_date = (starts_on + (week - 1).weeks)
          expect(page).to have_content(I18n.l(week_date, format: :short))
        end
      end

      within(".week_8") do
        expect(page).to have_content("Race week")
      end
    end
  end

end
