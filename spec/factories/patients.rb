FactoryGirl.define do
  factory :patient do
    name { Forgery(:name).full_name }
    mobile { Forgery(:address).phone }
    email { Forgery(:internet).email_address }
    address { Forgery(:address).street_address }
    eligible false
    finished true
    trial
    factory :not_finished_patient do
      finished false
    end
    factory :not_eligible_patient do
      eligible false
    end
  end
end
