class PatientMailer < ActionMailer::Base
  default from: "from@example.com"

  def remind(patient)
    @patient = patient
    @trial = @patient.trial
    mail to: patient.email
  end
end
