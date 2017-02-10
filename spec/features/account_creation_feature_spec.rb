require 'spec_helper'

describe 'acount creation' do
  it 'allows user to create account' do
    visit root_path
    click_link 'Create Account'

    # fill_in 'Name', with: 'George'
    # fill_in 'Email', with: 'george@dringo.io'
    # fill_in 'Password', with: 'password'
    # fill_in 'Password Confirmation', with: 'password'
    fill_in 'Subdomain', with: 'test_subdomain'
    click_button 'Create Account'

    expect(page).to have_content('Signed up successfully')
  end
end
