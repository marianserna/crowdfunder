FactoryBot.define do
  factory :project do
    title "Ball Dance"
    description "Raising money for the ball dance"
    goal 5000
    start_date { Date.tomorrow }
    end_date { Date.tomorrow + 7.days }
    user
    category
  end
end
