require 'spec_helper'
require 'rails_helper'

describe 'acount creation' do
  let(:subdomain) { FactoryGirl.generate(:subdomain) }
  before(:each) { sign_up(subdomain) }

  it 'allows user to create account' do
    expect(page.current_url).to include(subdomain)
    expect(Account.all.count).to eq(1)
  end

  it 'allows access of subdomain' do
    visit root_url(subdomain: subdomain)
    expect(page.current_url).to include(subdomain)
  end

  def sign_up(subdomain)
    visit root_url(subdomain: false)
    click_link 'Create Account'

    fill_in 'Name', with: 'George'
    fill_in 'Email', with: 'george@dringo.io'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'Subdomain', with: subdomain
    click_button 'Create Account'
  end
end
