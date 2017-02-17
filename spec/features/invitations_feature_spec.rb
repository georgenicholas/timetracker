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

  describe 'when user is invited' do
    before do
      fill_in 'Email', with: 'ryan@tanookilabs.com'
      click_button 'Invite User'
    end

    it 'shows invitation' do
      expect(page).to have_content 'invitation email has been sent'
      expect(page).to have_content 'ryan@tanookilabs.com'
      expect(page).to have_content 'Invitation Pending'
      clear_emails
    end

    context 'user accepts invitation' do
      before do
        visit users_path
        click_link 'Sign out'
        open_email 'ryan@tanookilabs.com'
        current_email.click_link 'Accept invitation'
        fill_in 'Name', with: 'Ryan Boland'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Create Account'
      end
      #  clear_emails

      it 'confirms account create' do
        expect(page).to have_content 'Your password was set successfully.'
      end

      it 'shows a checkmark on the users page' do
        visit users_path
        within('tr', text: 'Ryan Boland') do
          expect(page).to have_selector '.glyphicon-ok'
        end
      end
    end
  end
end
