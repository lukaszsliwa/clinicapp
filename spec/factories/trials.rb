FactoryGirl.define do
  factory :trial do
    name { Forgery(:lorem_ipsum).sentences(1, :random => true) }
    start_on { DateTime.yesterday }
    stop_on { DateTime.tomorrow }
    factory :trial_with_questions do
      after :create do |instance|
        create :question, :questionable => instance
      end
    end
  end
end
