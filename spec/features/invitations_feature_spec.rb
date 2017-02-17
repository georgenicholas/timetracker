require 'spec_helper'
require 'rails_helper'
require 'pry'
include Capybara::Email::DSL
describe 'invitations' do
  let(:user) {build(:user) }
  let!(:account) { create(:account_with_schema, owner: user) }

  before do
    set_subdomain(account.subdomain)
    sign_user_in(user, subdomain: account.subdomain)
    visit users_path
  end

  it 'shows the owner in the authorized users list' do
    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_selector '.glyphicon-ok'
  end

  it 'shows invitation when user is invited' do
    fill_in 'Email', with: 'ryan@tanookilabs.com'
    click_button 'Invite User'
    expect(page).to have_content 'invitation email has been sent'
    expect(page).to have_content 'ryan@tanookilabs.com'
    expect(page).to have_content 'Invitation Pending'
    clear_emails 
  end

  it 'allows user to accept invitation' do
    clear_emails
    fill_in 'Email', with: 'ryan@tanookilabs.com'
    click_button 'Invite User'
    visit users_path
    click_link 'Sign out'
    binding.pry
    open_email 'ryan@tanookilabs.com'
    current_email.click_link 'Accept invitation'

    fill_in 'Name', with: 'Ryan Boland'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click _button 'Create Account'
    expect(page).to have_content 'Your account was created successfully'
  end
end
