FactoryGirl.define do
  factory :classification do
    name_ja { Faker::Name.first_name }
    name_en { Faker::Name.first_name }
  end
end
