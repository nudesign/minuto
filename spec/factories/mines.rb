FactoryGirl.define do
  factory :mine do
    sequence(:title) { |n| "Mine Fashion #{n}" }
    resume  "MyText"
  end
end
