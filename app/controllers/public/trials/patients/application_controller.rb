class Public::Trials::Patients::ApplicationController < Public::Trials::ApplicationController
  before_filter :patient

  def patient
    if params[:patient_id] and params[:token]
      @patient = Patient.not_finished.where(:token => params[:token]).find params[:patient_id]
      session[:patient_id] = @patient.id
    else
      @patient = Patient.not_finished.find(session[:patient_id])
    end
  end
end
