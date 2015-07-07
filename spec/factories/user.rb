FactoryGirl.define do
  factory :user do
    users_password = Faker::Internet.password(8, 72)

    first_name            Faker::Name.first_name
    last_name             Faker::Name.last_name
    email                 Faker::Internet.safe_email
    password              users_password
    password_confirmation users_password
    details               factory: :end_user_detail
  end
end
