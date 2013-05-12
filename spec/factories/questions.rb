FactoryGirl.define do
  factory :question do
    text { Forgery(:lorem_ipsum).sentences(2, :random => true) }
    type 'text'
    factory :text_question do
      type 'text'
    end
    factory :area_question do
      type 'area'
    end
    factory :choices_question do
      choices %w{Male Female}
      type 'choices'
    end
  end
end
