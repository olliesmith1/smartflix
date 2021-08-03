FactoryBot.define do
  factory :movie do
    title { "Cars" }
    created_at { "2008-01-01 15:03:00.357419000 +0000" }
    updated_at { "2008-01-01 15:03:00.357419000 +0000" }
    imdb_votes { "380,993" }
    response { "True" }
    timestamp { "2008-01-01 12:03:13.004339 +0100" }
  end
end