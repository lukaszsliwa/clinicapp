class PatientsController < ApplicationController
  before_filter :patient, :only => [:show, :destroy]

  def index
    @patients = Patient.recent.search(params).name_query(params).page params[:page]
  end

  def show
  end

  def destroy
    @patient.destroy
  end

  private

  def patient
    @patient ||= Patient.find params[:id]
  end
end
