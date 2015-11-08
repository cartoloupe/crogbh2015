FactoryGirl.define do
  factory :service do
    description { Faker::Lorem.paragraph }
    name        { Faker::Company.name }
    website     { Faker::Internet.url }
  end
end
