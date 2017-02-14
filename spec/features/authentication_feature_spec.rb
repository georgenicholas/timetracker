require 'spec_helper'

describe 'user authentication' do
  it 'allows signin with valid credentials' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully')
  end

  it 'does not allow signin with invalid credentials' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong password'
    click_button 'Sign in'

    expect(page).to have_content('Invalid email or password')
  end
end
