require 'rails_helper'

RSpec.feature 'Registration' do

  scenario 'Visitor starts new account' do
    visit root_path
    click_link 'Start your Pursuit'

    fill_form :user, {
      'Email' => generate(:email),
      'user[password]' => 'password',
      'user[password_confirmation]' => 'password'
    }

    click_button 'Go'

    expect(page).to have_content('Welcome')
  end
end
