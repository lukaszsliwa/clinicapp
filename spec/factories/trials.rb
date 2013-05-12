FactoryGirl.define do
  factory :trial do
    name { Forgery(:lorem_ipsum).sentences(1, :random => true) }
    start_on { DateTime.now }
    stop_on { DateTime.now }
  end
end
