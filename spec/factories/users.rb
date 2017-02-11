FactoryGirl.define do
  factory :user do
    name 'George'
    sequence(:email) { |n| "email#{n}@gmail.com" }
    password 'password'
  end
end
