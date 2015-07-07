FactoryGirl.define do
  factory :end_user_detail do
    city    Faker::Address.city
    state   Faker::Address.state_abbr
    zip     Faker::Number.number([5, 9].sample)
    gender  ['M', 'F', 'O', ''].sample
    phone   Faker::Number.number(10)
    address Faker::Address.street_address
  end
end
