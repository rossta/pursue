require 'rails_helper'

feature 'Athlete Dashboard' do

  context 'Athletes' do
    let(:athlete) { create(:user) }

    scenario 'handle schedule w/o plan' do
      create(:schedule, title: "Training for IM",owner: athlete, starts_on: 4.days.ago)

      login_as athlete

      visit dashboard_path

      expect(page).to have_content("Training for IM")
    end

    context 'with schedule' do
      let(:training_plan) { create(:training_plan, total_weeks: 3) }

      before do
        training_plan.entries.create(attributes_for(:entry, week: 1, day: 1, summary: "Swim"))
        training_plan.entries.create(attributes_for(:entry, week: 1, day: 2, summary: "Bike"))
        training_plan.entries.create(attributes_for(:entry, week: 1, day: 2, summary: "Run"))
        training_plan.entries.create(attributes_for(:entry, week: 2, day: 1, summary: "Rest"))
      end

      scenario 'view upcoming workout' do
        create(:schedule, training_plan: training_plan, owner: athlete, starts_on: 1.day.ago)

        login_as athlete

        visit dashboard_path

        expect(page).to have_content "Today"
        expect(page).to have_content "Bike"
        expect(page).to have_content "Tomorrow"
        expect(page).to have_content "Run"
        expect(page).not_to have_content "Swim"

        Timecop.travel(1.day.from_now)
        expect(page).to have_content "Today"
        expect(page).to have_content "Run"
        expect(page).to have_content "Tomorrow"
        expect(page).to have_content "Nothing scheduled"
        expect(page).not_to have_content "Swim"
        expect(page).not_to have_content "Bike"
      end

      scenario 'link to workout plans for schedule week' do
        create(:schedule, training_plan: training_plan, owner: athlete, starts_on: 1.day.ago)

        login_as athlete

        visit dashboard_path

        click_link "Week 1"

        expect(page).to have_content("Swim")
        expect(page).to have_content("Bike")
        expect(page).to_not have_content("Rest")
      end

    end
  end
end
