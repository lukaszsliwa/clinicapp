require 'spec_helper'

describe Public::Trials::Patients::QuestionsController do
  let(:trial) { create(:trial) }
  before do
    @patient = create(:not_finished_patient)
    @question1 = create(:text_question, :questionable => @patient)
    @question2 = create(:area_question, :questionable => @patient)
    @question3 = create(:choices_question, :questionable => @patient)
  end
  describe '#index' do
    it 'should go to page 1, 2 and 3' do
      get :index, {:trial_id => trial, :page => 1}, {:patient_id => @patient.id}
      response.should render_template('public/trials/patients/questions/index')

      get :index, {:trial_id => trial, :page => 2}, {:patient_id => @patient.id}
      response.should render_template('public/trials/patients/questions/index')

      get :index, {:trial_id => trial, :page => 3}, {:patient_id => @patient.id}
      response.should render_template('public/trials/patients/questions/index')
    end
    it 'should redirect to the last page with eligible info' do
      get :index, {:trial_id => trial, :page => 4}, {:patient_id => @patient.id}
      response.should redirect_to(public_trial_patient_path(trial))
    end
    it 'should use patient_id and token to find patient' do
      get :index, {:trial_id => trial, :page => 1, :patient_id => @patient.id, :token => @patient.token}
      response.should render_template('public/trials/patients/questions/index')
    end
  end
  describe '#update' do
    it 'should update update text choice' do
      expect {
        put :update, {:trial_id => trial, :id => @question1, :question => {:patient_answer => 'Yes'}}, {:patient_id => @patient.id}
      }.to change { Patient.find(@patient.id).questions.find(@question1.id).patient_answer }.to('Yes')
    end
    it 'should update update area choice' do
      expect {
        put :update, {:trial_id => trial, :id => @question2, :question => {:patient_answer => "Yes\nNo"}}, {:patient_id => @patient.id}
      }.to change { Patient.find(@patient.id).questions.find(@question2.id).patient_answer }.to("Yes\nNo")
    end
    it 'should update update choices choice' do
      expect {
        put :update, {:trial_id => trial, :id => @question3, :question => {:patient_answer => %w{A B}}}, {:patient_id => @patient.id}
      }.to change { Patient.find(@patient.id).questions.find(@question3.id).patient_answer }.to(%w{A B})
    end
    it 'should redirect back when update_attribute returns false' do
      Question.any_instance.expects(:save).returns false
      put :update, {:trial_id => trial, :id => @question1, :question => {}, :page => 1}, {:patient_id => @patient.id}
      response.should redirect_to(public_trial_patient_questions_path(trial, :page => 1))
    end
  end
end
