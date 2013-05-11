class Public::Trials::PatientsController < Public::Trials::ApplicationController

  before_filter :patient, :only => [:edit, :update, :show]

  layout 'public'

  def new
    @patient = Patient.new
  end

  def create
    @patient = @trial.patients.build(params[:patient])
    respond_to do |format|
      if @patient.save
        format.html { redirect_to public_trial_patient_choices_path(@trial, @patient, :page => 1) }
      else
        format.html { render :action => :new }
      end
    end
  end

  def show
  end

  private

  def patient
    @patient ||= Patient.find(params[:id])
  end
end
