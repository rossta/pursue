require 'rails_helper'

feature 'Athlete Dashboard' do

  context 'Athletes' do
    let(:athlete) { create(:user) }

    scenario 'handle schedule w/o plan' do
      schedule = create(:schedule, owner: athlete, starts_on: 4.days.ago)

      login_as athlete

      visit schedule_path(schedule)

      expect(page).to have_content("Wannabe Plan")
    end

    scenario 'list workout plans for schedule week' do
      training_plan = create(:training_plan, total_weeks: 3)
      training_plan.entries.create(attributes_for(:entry, week: 1, summary: "Swim"))
      training_plan.entries.create(attributes_for(:entry, week: 1, summary: "Bike"))
      training_plan.entries.create(attributes_for(:entry, week: 2, summary: "Rest"))

      schedule = create(:schedule,
       training_plan: training_plan,
       owner: athlete,
       starts_on: 4.days.ago)

      login_as athlete

      visit schedule_path(schedule)

      click_link "Week 1"

      expect(page).to have_content("Swim")
      expect(page).to have_content("Bike")
      expect(page).to_not have_content("Rest")
    end

  end
end
