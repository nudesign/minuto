FactoryGirl.define do
  factory :inspiration do
    title         "MyString"
    tag_list      ""
    resume        "MyText"
    description   "MyText"
    main_category "design"
    published     true
    published_at  { Date.today }
  end

  factory :draft_inspiration, parent: :inspiration do
    published     false
    published_at  nil
  end
end
