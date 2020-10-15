FactoryBot.define do
  factory :reservation do
    association :user
    association :menu
    reservation_year { 2020 }
    reservation_month { "1" }
    reservation_day { "1" }
    reservation_time { "19" }
    people { 2 }
    reservation_status { 0 }
  end
end
