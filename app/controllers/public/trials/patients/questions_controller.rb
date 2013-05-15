class Public::Trials::Patients::QuestionsController < Public::Trials::Patients::ApplicationController
  def index
    @questions = @patient.questions.order_by('created_at asc').page(params[:page]).per(1).all
    unless @questions.present?
      @patient.finish!
      redirect_to public_trial_patient_path(@trial)
    end
  end

  def update
    @question = @patient.questions.find(params[:id])
    @question.assign_attributes(params[:question], :as => :patient)
    respond_to do |format|
      if @question.save
        format.html { redirect_to public_trial_patient_questions_path(@trial, :page => params[:page].to_i + 1) }
      else
        format.html { redirect_to public_trial_patient_questions_path(@trial, :page => params[:page]), :notice => 'Your choice is invalid.' }
      end
    end
  end
end
