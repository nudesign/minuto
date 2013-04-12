FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@nu.com"
  end

  factory :user do
    email { FactoryGirl.generate(:email) }
    password "1234567"
    password_confirmation "1234567"
  end
end