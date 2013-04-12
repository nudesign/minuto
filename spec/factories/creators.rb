# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :creator do
    name          "MyString"
    location      "MyString"
    occupation    "MyString"
    release       "MyText"
    interview     "MyText"
    main_category "art"
    state         "published"
  end

  factory :draft_creator, parent: :creator do
    state :draft
  end

  factory :blank_creator, class: Creator do
  end
end
