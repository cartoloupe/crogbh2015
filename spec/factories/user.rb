FactoryGirl.define do
  factory :user do
    user_password = Faker::Internet.password(8, 72)

    first_name            Faker::Name.first_name
    last_name             Faker::Name.last_name
    email                 Faker::Internet.safe_email
    password              user_password
    password_confirmation user_password
    details               factory: :end_user_detail
  end
end
