FactoryGirl.define do
  factory :product do
    name 'chair star'
    store_name 'New Store'
    store_link 'http://www.newstore.com'
    price 99.78

    size '2x1'
    main_category 'design'
    categories ['design', 'style']
  end

  factory :product_mine, parent: :product do
    association :mine, factory: :mine
  end
end
