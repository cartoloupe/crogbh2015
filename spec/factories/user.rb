FactoryGirl.define do
  factory :user, class: User do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.safe_email }
    password              { Faker::Internet.password(8, 72) }
    password_confirmation { password }
    details               factory: :end_user_detail

    trait :administrator do
      details factory: :admin_user_detail
    end
  end
end
