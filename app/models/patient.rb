class Patient
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected :token, :eligible, :finished

  field :name, type: String
  field :mobile, type: String
  field :address, type: String
  field :email, type: String
  field :eligible, type: Boolean, default: false
  field :finished, type: Boolean, default: false
  field :token, type: String

  validates :name, :presence => true
  validates :mobile, :presence => true
  validates :address, :presence => true
  validates :email, :presence => true

  embeds_many :choices, :as => :choiceable

  index 'choices.id' => 1
  index({:eligible => 1, :trial_id => 1})
  index :token => 1

  belongs_to :trial

  before_create :copy_choices_from_trial
  before_create :generate_token

  def copy_choices_from_trial
    self.trial.choices.each do |choice|
      choice = choice.clone
      choice.copy_question_text
      self.choices << choice
    end
  end

  def generate_token
    self.token = SecureRandom.hex
  end

  def eligible_now?
    choices.all.all? do |choice|
      choice.eligible?
    end
  end

  def eligible!
    self.eligible = eligible_now?
    save
  end

  def finish!
    self.finished = true
    eligible!
  end
end
