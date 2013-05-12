class PatientMailer < ActionMailer::Base
  default from: "from@example.com"

  def remind(patient)
    mail to: patient.email
  end
end
