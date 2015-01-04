require 'rails_helper'

RSpec.feature 'Workout Plan' do

  context 'Coaches' do
    let(:coach) { create(:user) }

    scenario 'create workout plan' do
      Tag.seed_fixtures(:disciplines)
      training_plan = create(:training_plan, creator: coach)

      login_as coach

      visit new_training_plan_entry_path(training_plan)

      fill_form :entry, {
        discipline: 'run',
        summary: '5 miles easy',
        notes: 'Effort should be really light.',
        distance: '5 mi',
        duration: '48 min',
        day: 'Monday',
        week: 1
      }

      click_button 'Go'

      expect(page).to have_content('Run')
      expect(page).to have_content('5 miles easy')
      expect(page).to have_content('Effort should be really light.')

      within("[data-role=distance]") do
        expect(page).to have_content("5 mi")
      end

      within("[data-role=duration]") do
        expect(page).to have_content("48 min")
      end
    end

    scenario 'list workout plans for training plan week' do
      training_plan = create(:training_plan, creator: coach)

      training_plan.entries.create(attributes_for(:entry, week: 1, summary: "Swim"))
      training_plan.entries.create(attributes_for(:entry, week: 1, summary: "Bike"))

      training_plan.entries.create(attributes_for(:entry, week: 2, summary: "Rest"))

      visit training_plan_path(training_plan)

      click_link "Week 1 Prep Train"

      expect(page).to have_content("Swim")
      expect(page).to have_content("Bike")
      expect(page).to_not have_content("Rest")
    end
  end

  context 'Athletes' do
    let(:coach) { create(:user) }
    let(:athlete) { create(:user) }

    scenario 'list workout plans for schedule week' do
      training_plan = create(:training_plan, creator: coach, total_weeks: 6)
      event         = create(:event, occurs_on: 6.months.from_now.end_of_week)

      training_plan.entries.create(attributes_for(:entry, week: 1, summary: "Swim"))
      training_plan.entries.create(attributes_for(:entry, week: 1, summary: "Bike"))
      training_plan.entries.create(attributes_for(:entry, week: 2, summary: "Rest"))

      schedule = create(:schedule, owner: athlete, event: event, training_plan: training_plan)
      login_as athlete

      visit schedule_path(schedule)

      click_link "Week 1"

      expect(page).to have_content("Swim")
      expect(page).to have_content("Bike")
      expect(page).to_not have_content("Rest")
    end

  end

end
