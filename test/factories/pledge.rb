FactoryBot.define do
  factory :pledge do
    dollar_amount 50.0
    user
    project
  end
end
