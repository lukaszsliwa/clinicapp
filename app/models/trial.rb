class Trial
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid

  field :start_on, type: DateTime
  field :stop_on, type: DateTime
  field :name, type: String

  as_enum :type, [:opened, :closed, :start_stop]

  validates :name, :presence => true

  has_many :patients
  embeds_many :questions, :as => :questionable

  index 'choices.id' => 1
  index({:start_on => 1, :stop_on => 1})

  scope :active, ->(current = DateTime.now) {
    any_of({:type_cd => Trial.types(:opened)}, {:type_cd => Trial.types(:start_stop), :start_on.lte => current, :stop_on.gte => current})
  }

  accepts_nested_attributes_for :questions, :allow_destroy => true
end
