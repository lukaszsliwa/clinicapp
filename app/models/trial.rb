class Trial
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps

  field :start_on, type: DateTime
  field :stop_on, type: DateTime
  field :name, type: String

  validates :name, :presence => true

  has_many :patients
  embeds_many :choices, :as => :choiceable

  index 'choices.id' => 1
  index({:start_on => 1, :stop_on => 1})

  scope :open, ->(current = DateTime.now) {
    where(:start_on.lte => current, :stop_on.gte => current)
  }

  accepts_nested_attributes_for :choices
end
