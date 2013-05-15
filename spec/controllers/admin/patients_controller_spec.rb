require 'spec_helper'

describe Admin::PatientsController do
  before do
    @patient = create(:patient)
  end
  describe '#index' do
    it 'should get all patients' do
      get :index
      response.should render_template('admin/patients/index')
      assigns(:patients).to_a.should eql [@patient]
    end
  end
  describe '#show' do
    it 'should show patient' do
      get :show, :id => @patient, :format => :js
      response.should render_template('admin/patients/show')
    end
  end
  describe '#destroy' do
    it 'should destroy patient' do
      expect {
        delete :destroy, :id => @patient, :format => :js
        response.should render_template('admin/patients/destroy')
      }.to change(Patient, :count)
    end
  end
end
