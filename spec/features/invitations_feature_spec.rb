require 'spec_helper'
require 'rails_helper'
#require 'pry'
describe 'invitations' do
  let(:user) {build(:user) }
  let!(:account) { create(:account_with_schema, owner: user) }


  # let!(:account) { create(:account_with_schema) }
  # let(:user) { account.owner }
  #
  before { set_subdomain(account.subdomain) }

  it 'shows the owner in the authorized users list' do
    sign_user_in(user, subdomain: account.subdomain)

    # sign_user_in(user)
    #binding.pry
    visit users_path
    #binding.pry
    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_selector '.glyphicon-ok'

  end
end
