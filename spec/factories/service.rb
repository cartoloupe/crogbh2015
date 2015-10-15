FactoryGirl.define do
  factory :service do
    description { Faker::Lorem.paragraph }
    name        { Faker::Company.name }
  end
end
