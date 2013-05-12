class Public::Trials::Patients::ApplicationController < Public::Trials::ApplicationController
  before_filter :patient

  def patient
    @patient ||= Patient.not_finished.find(session[:patient_id])
  end
end
