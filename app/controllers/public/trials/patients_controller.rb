class Public::Trials::PatientsController < Public::Trials::ApplicationController
  layout 'public'

  def new
    @patient = Patient.new
  end

  def create
    @patient = @trial.patients.build(params[:patient])
    respond_to do |format|
      if @patient.save
        session[:patient_id] = @patient.id
        format.html { redirect_to public_trial_patient_choices_path(@trial, :page => 1) }
      else
        format.html { render :action => :new }
      end
    end
  end

  def show
    @patient ||= Patient.finished.find(session[:patient_id])
  end
end
