class PatientsController < ApplicationController
  before_filter :patient, :only => [:show, :destroy]

  def index
    @patients = Patient.all
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
