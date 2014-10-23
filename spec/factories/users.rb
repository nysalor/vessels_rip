FactoryGirl.define do
  factory :user do
    uid { Faker::Lorem.characters(16) }
    screen_name { Faker::Name.first_name }
  end

end
