class Choice
  include Mongoid::Document
  field :question_id, type: Integer
  field :question_text, type: String
  field :suggested_value
  field :patient_value

  belongs_to :question

  embedded_in :choiceable, :polymorphic => true

  # Mongoid fails on embedded document callback
  # before_create :copy_question_text

  def copy_question_text
    self.question_text = question.text
  end

  def eligible?
    !suggested_value.present? || suggested_value == patient_value
  end
end
