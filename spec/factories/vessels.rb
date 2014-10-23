FactoryGirl.define do
  factory :vessel do
    name_ja { Faker::Name.first_name }
    name_en { Faker::Name.first_name }
    type_name { Faker::Name.first_name }
    sunk_at {
      Time.zone.parse("1941-12-08 8:00:00 JST").since(rand(116_308_800))
    }
    place_name { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    association :user, factory: :user
    association :cause, factory: :cause
    association :classification, factory: :classification
  end
end
