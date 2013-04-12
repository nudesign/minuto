# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title       "My title"
    description "lorem ipsum"
    type        "creators"
  end
end
