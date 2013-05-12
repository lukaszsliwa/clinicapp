require 'spec_helper'

describe Public::Trials::PatientsController do
  let(:trial) { create(:trial_with_choices) }
  describe '#new' do
    it 'should get a new patient' do
      get :new, {:trial_id => trial.id}
      response.should render_template('public/trials/patients/new')
      assigns(:patient).new_record?.should be_true
    end
  end
  describe '#create' do
    context 'when patient attributes are correct' do
      it 'should create new patient and save id into the session' do
        expect {
          post :create, :trial_id => trial, :patient => attributes_for(:patient)
          response.should redirect_to(public_trial_patient_choices_path(trial, :page => 1))
        }.to change(Patient, :count).by 1
        session[:patient_id].should eql assigns(:patient).id
      end
    end
    context 'when patient attributes are not correct' do
      before do
        Patient.any_instance.expects(:save).returns(false)
      end
      it 'should render patient details page again' do
        expect {
          post :create, :trial_id => trial, :patient => {}
          response.should render_template('public/trials/patients/new')
        }.to_not change(Patient, :count)
        session[:patient_id].should be_nil
      end
    end
  end
  describe '#show' do
    context 'when patient has finished a test' do
      before do
        @patient = create(:patient, :trial => trial)
      end
      it 'should get patient' do
        get :show, {:trial_id => trial}, {:patient_id => @patient.id}
        response.should render_template('public/trials/patients/show')
      end
    end
    context 'when patient has not finished a test' do
      before do
        @patient = create(:not_finished_patient, :trial => trial)
      end
      it 'should get patient' do
        expect {
          get :show, {:trial_id => trial}, {:patient_id => @patient.id}
        }.to raise_error(Mongoid::Errors::DocumentNotFound)
      end
    end
  end
end
