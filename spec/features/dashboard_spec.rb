require 'rails_helper'

RSpec.feature 'Athlete Dashboard' do

  context 'Athletes' do
    let(:athlete) { create(:user) }

    scenario 'handle schedule w/o plan' do
      create(:schedule, title: "Training for IM",owner: athlete, starts_on: 4.days.ago)

      login_as athlete

      visit dashboard_path

      expect(page).to have_content("Training for IM")
    end

    context 'with schedule', :pending do
      let(:training_plan) { create(:training_plan, total_weeks: 3) }

      before do
        training_plan.entries.create(attributes_for(:entry, week: 1, day: 1, summary: "Swim"))
        training_plan.entries.create(attributes_for(:entry, week: 1, day: 2, summary: "Bike"))
        training_plan.entries.create(attributes_for(:entry, week: 1, day: 2, summary: "Run"))
        training_plan.entries.create(attributes_for(:entry, week: 2, day: 1, summary: "Rest"))
      end

    end
  end
end
