require 'rails_helper'

feature 'Training Plans' do

  context 'Coaches' do
    let(:coach) { create(:user) }

    scenario 'create training plan' do
      login_as coach

      visit new_training_plan_path

      fill_form :training_plan, {
        title: 'Your Best Half Ironman',
        summary: '36 weeks to your best HIM',
        discipline: 'half-ironman'
      }

      click_button 'Go'

      expect(page).to have_content('Your Best Half Ironman')
      expect(page).to have_content('36 weeks to your best HIM')
    end
  end

  context 'Athletes' do
    let(:athlete) { create(:user) }

    scenario 'choose a training plan', :pending do
      create(:training_plan)
      login_as athlete

      visit training_plans_path

      click_link "Start training"
    end
  end

end
