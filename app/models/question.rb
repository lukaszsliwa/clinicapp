class Question
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include SimpleEnum::Mongoid

  field :text, type: String
  field :choices, type: Array, default: []
  field :type, type: String

  as_enum :type, [:text, :area, :choices]

  validates :text, :presence => true
  validates :type, :presence => true

  before_save :clear_choices, :unless => :choices?
  before_save :remove_blank_choices, :if => :choices?

  def clear_choices
    self.choices = []
  end

  def remove_blank_choices
    self.choices.reject!(&:blank?)
  end
end
