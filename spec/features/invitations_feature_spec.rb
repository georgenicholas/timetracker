require 'spec_helper'
require 'rails_helper'
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
    expect(page).to have_content 'invitation email hsa been sent'
    expect(page).to have_content 'ryan@tanookilabs.com'
    expect(page).to have_content 'Invitation Pending'
  end
end
