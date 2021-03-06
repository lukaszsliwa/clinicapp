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
  validates :email, :presence => true, :confirmation => true

  scope :yesterday, where(:created_at.gte => Date.yesterday, :created_at.lte => Date.today)
  scope :recent, order_by('created_at desc')
  scope :finished, where(:finished => true)
  scope :not_finished, where(:finished => false)
  scope :search, ->(params = {}) do
    params.delete :trial_id if params[:trial_id].blank?
    where params.slice :eligible, :finished, :trial_id
  end
  scope :name_query, ->(params = {}) do
    where :name => /#{params[:q]}/ unless params[:q].blank?
  end

  embeds_many :questions, :as => :questionable
  accepts_nested_attributes_for :questions

  index 'choices.id' => 1
  index({:eligible => 1, :trial_id => 1})
  index :finished => 1
  index :token => 1

  belongs_to :trial

  before_create :copy_questions_from_trial
  before_create :generate_token

  def copy_questions_from_trial
    self.trial.questions.each do |question|
      self.questions << question.clone
    end
  end

  def generate_token
    self.token = SecureRandom.hex
  end

  def eligible_now?(from = 0, to = questions.size)
    return true if from >= to
    questions.all[from, to].all? do |question|
      question.eligible?
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

  def self.remind_if_not_finished
    Patient.not_finished.yesterday.each do |patient|
      PatientMailer.remind(patient).deliver
    end
  end
end
