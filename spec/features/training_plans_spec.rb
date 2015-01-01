require 'rails_helper'

RSpec.feature 'Training Plans' do

  scenario 'list training plans' do
    create(:training_plan, title: 'Your Best Triathlon')
    create(:training_plan, title: 'Your Best Marathon')

    visit training_plans_path

    expect(page).to have_content('Your Best Triathlon')
    expect(page).to have_content('Your Best Marathon')
  end

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

end
