require 'spec_helper'
require 'rails_helper'
require 'pry'

describe 'invitations' do
  let(:user) {build(:user) }
  let!(:account) { create(:account_with_schema, owner: user) }

  before do
    set_subdomain(account.subdomain)  
    sign_user_in(user, subdomain: account.subdomain)
    visit users_path
  end

  it "allows projects to be created" do
    visit root_path
    click_link "New Project"

    fill_in "Name", with: "A great project"
    fill_in "Client", with: "NASA"
    expect(page).to_not have_text "Archived"
    click_button "Create Project"

    expect(page).to have_text "Project created!"
    expect(page).to have_text "A great project"
  end

  it "displays project validations" do
    visit root_path
    click_link "New Project"

    click_button "Create Project"
    expect(page).to have_text "can't be blank"
  end
end
