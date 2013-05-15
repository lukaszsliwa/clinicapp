class Question
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include SimpleEnum::Mongoid

  field :text, type: String
  field :choices, type: Array, default: []
  field :correct_answer, type: String, default: ''
  field :patient_answer, type: String
  field :type, type: String

  attr_protected :text, :choices, :correct_answer, :type, :as => :patient

  embedded_in :questionable, :polymorphic => true

  as_enum :type, [:text, :area, :choices]

  validates :text, :presence => true
  validates :type, :presence => true

  before_save :clear_choices, :unless => :choices?
  before_save :remove_blank_choices, :if => :choices?

  def eligible?
    !correct_answer.present? || correct_answer.to_s == patient_answer.to_s ||
        correct_answer.kind_of?(Array) && correct_answer.include?(patient_answer.to_s)
  end

  def clear_choices
    self.choices = []
  end

  def remove_blank_choices
    self.choices.reject!(&:blank?)
  end
end
