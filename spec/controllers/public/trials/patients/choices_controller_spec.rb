require 'spec_helper'

describe Public::Trials::Patients::ChoicesController do
  let(:trial) { create(:trial) }
  before do
    @patient = create(:not_finished_patient)
    @choice1 = create(:text_choice, :choiceable => @patient)
    @choice2 = create(:area_choice, :choiceable => @patient)
    @choice3 = create(:choices_choice, :choiceable => @patient)
  end
  describe '#index' do
    it 'should go to page 1, 2 and 3' do
      get :index, {:trial_id => trial, :page => 1}, {:patient_id => @patient.id}
      response.should render_template('public/trials/patients/choices/index')

      get :index, {:trial_id => trial, :page => 2}, {:patient_id => @patient.id}
      response.should render_template('public/trials/patients/choices/index')

      get :index, {:trial_id => trial, :page => 3}, {:patient_id => @patient.id}
      response.should render_template('public/trials/patients/choices/index')
    end
    it 'should redirect to the last page with eligible info' do
      get :index, {:trial_id => trial, :page => 4}, {:patient_id => @patient.id}
      response.should redirect_to(public_trial_patient_path(trial))
    end
  end
  describe '#update' do
    it 'should update update text choice' do
      expect {
        put :update, {:trial_id => trial, :id => @choice1, :choice => {:patient_value => 'Yes'}}, {:patient_id => @patient.id}
      }.to change { Patient.find(@patient.id).choices.find(@choice1.id).patient_value }.to('Yes')
    end
    it 'should update update area choice' do
      expect {
        put :update, {:trial_id => trial, :id => @choice2, :choice => {:patient_value => "Yes\nNo"}}, {:patient_id => @patient.id}
      }.to change { Patient.find(@patient.id).choices.find(@choice2.id).patient_value }.to("Yes\nNo")
    end
    it 'should update update choices choice' do
      expect {
        put :update, {:trial_id => trial, :id => @choice3, :choice => {:patient_value => %w{A B}}}, {:patient_id => @patient.id}
      }.to change { Patient.find(@patient.id).choices.find(@choice3.id).patient_value }.to(%w{A B})
    end
    it 'should redirect back when update_attribute returns false' do
      Choice.any_instance.expects(:update_attributes).returns false
      put :update, {:trial_id => trial, :id => @choice1, :choice => {}, :page => 1}, {:patient_id => @patient.id}
      response.should redirect_to(public_trial_patient_choices_path(trial, :page => 1))
    end
  end
end
