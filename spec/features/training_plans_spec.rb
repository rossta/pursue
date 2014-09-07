require 'rails_helper'

feature 'Training Plans' do

  context 'Coaches' do
    let(:coach) { create(:user) }

    scenario 'create training plan' do
      login_as coach

      visit new_training_plan_path

      fill_form :training_plan, {
        title: 'Your Best Half Ironman',
        summary: '36 weeks to your best HIM'
      }

      click_button 'Go'

      expect(page).to have_content('Your Best Half Ironman')
      expect(page).to have_content('36 weeks to your best HIM')
    end
  end

end
