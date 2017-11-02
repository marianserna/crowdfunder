FactoryBot.define do
  factory :comment do
    text "comment_1"
    user
    project
  end
end
