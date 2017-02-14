require 'spec_helper'

describe 'acount creation' do
  it 'allows user to create account' do
    visit root_path
    click_button 'Create Account'

    fill_in 'name', with: 'George'
    fill_in 'email', with: 'george@dringo.io'
    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'password'
    fill_in 'subdomain', with: 'test_subdomain'
    click_button 'Submit'

    expect(page).to have_content('Signed up successfully')
  end
end
