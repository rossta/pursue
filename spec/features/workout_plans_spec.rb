require 'rails_helper'

feature 'Workout Plan' do

  context 'Coaches' do
    let(:coach) { create(:user) }

    scenario 'create workout plan' do
      training_plan = create(:training_plan, creator: coach)

      login_as coach

      visit new_training_plan_workout_plan_path(training_plan)

      fill_form :workout_plan, {
        # discipline: 'Run',
        summary: '5 miles easy',
        notes: 'Effort should be really light.',
        week: 1,
        day: 'Monday'
      }

      click_button 'Go'

      # expect(page).to have_content('Run')
      expect(page).to have_content('5 miles easy')
      expect(page).to have_content('Effort should be really light.')
    end
  end

end
