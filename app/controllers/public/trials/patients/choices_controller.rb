class Public::Trials::Patients::ChoicesController < Public::Trials::Patients::ApplicationController
  def index
    @choices = @patient.choices.order_by('created_at asc').page(params[:page]).per(1).all
    unless @choices.present?
      @patient.finish!
      redirect_to public_trial_patient_path(@trial, @patient)
    end
  end

  def update
    @choice = @patient.choices.find(params[:id])
    respond_to do |format|
      if @choice.update_attributes(params[:choice])
        format.html { redirect_to public_trial_patient_choices_path(@trial, @patient, :page => params[:page].to_i + 1) }
      else
        format.html { redirect_to :back, :notice => 'You choice is invalid.' }
      end
    end
  end
end
