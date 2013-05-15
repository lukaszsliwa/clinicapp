require 'spec_helper'

describe Admin::TrialsController do
  before do
    @trial = create(:trial)
  end
  describe '#index' do
    it 'should get the list' do
      get :index
      response.should render_template('trials/index')
      assigns(:trials).to_a.should eql [@trial]
    end
  end
  describe '#new' do
    it 'should get new trial' do
      get :new
      response.should render_template('trials/new')
      assigns(:trial).new_record?.should be_true
    end
  end
  describe '#create' do
    context 'when attributes are correct' do
      it 'should create new trial' do
        expect {
          post :create, :trial => attributes_for(:trial)
          response.should redirect_to(admin_trials_path)
        }.to change(Trial, :count).by 1
      end
    end
    context 'when attributes are incorrect' do
      before do
        Trial.any_instance.expects(:save).returns false
      end
      it 'should create new trial' do
        expect {
          post :create, :trial => attributes_for(:trial)
          response.should render_template('trials/new')
        }.to change(Trial, :count).by 0
      end
    end
  end
  describe '#update' do
    context 'when attributes are correct' do
      it 'should create new trial' do
        put :update, :id => @trial, :trial => attributes_for(:trial)
        response.should redirect_to(admin_trials_path)
      end
    end
    context 'when attributes are incorrect' do
      before do
        Trial.any_instance.expects(:save).returns false
      end
      it 'should create new trial' do
        put :update, :id => @trial, :trial => attributes_for(:trial)
        response.should render_template('trials/edit')
      end
    end
  end
  describe '#destroy' do
    it 'should delete trial' do
      expect {
        delete :destroy, :id => @trial, :format => :js
        response.should render_template('trials/destroy')
      }.to change(Trial, :count).by -1
    end
  end
end
