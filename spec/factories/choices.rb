FactoryGirl.define do
  factory :choice do
    question
    question_text { Forgery(:lorem_ipsum).sentences(1, :random => true) }
    suggested_value 88
    patient_value 88
    factory :trial_choice do
      choiceable :factory => :trial
    end
    factory :patient_choice do
      choiceable :factory => :patient
    end
    factory :text_choice do
      patient_value 'Test'
    end
    factory :area_choice do
      patient_value 'Test\n\n\nTest'
    end
    factory :choices_choice do
      patient_value %w{A B C}
    end
  end
end
