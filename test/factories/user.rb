FactoryBot.define do
  factory :user do
    first_name "Pablo"
    last_name "Perez"
    sequence :email do |n|
      "pablo#{n}@email.com"
    end
    admin true
    password "soyowner"
    password_confirmation "soyowner"
  end
end
