require 'rails_helper'
require 'spec_helper'

# RSpec.describe Project, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Project do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :client }
  end

  describe "associations" do
  end

  it "defaults archived to false" do
    expect(Project.new).to_not be_archived
  end
end
