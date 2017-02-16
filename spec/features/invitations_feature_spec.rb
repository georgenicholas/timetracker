require 'spec_helper'
require 'rails_helper'

describe 'invitations' do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  it 'shows the owner in the authorized users list' do
    sign_user_in(user, subdomain: account.subdomain)
    visit users_url(subdomain: account.subdomain)
    expect(page).to have_content User.name
    expect(page).to have_selector '.glyphicon'
  end
end
