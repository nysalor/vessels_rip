FactoryGirl.define do
  factory :cause do
    description { Faker::Lorem.sentence }
  end
end
