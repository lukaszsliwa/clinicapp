class Public::Trials::Patients::ApplicationController < Public::Trials::ApplicationController
  before_filter :patient

  def patient
    @patient ||= Patient.find(params[:patient_id])
  end
end
