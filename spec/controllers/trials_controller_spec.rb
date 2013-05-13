require 'spec_helper'

describe TrialsController do
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
      get :new, :format => :js
      response.should render_template('trials/new')
      assigns(:trial).new_record?.should be_true
    end
  end
  describe '#create' do
    it 'should create new trial' do
      expect {
        post :create, :trial => attributes_for(:trial), :format => :js
        response.should render_template('trials/create')
      }.to change(Trial, :count).by 1
    end
  end
  describe '#update' do
    it 'should create new trial' do
      put :update, :id => @trial, :trial => attributes_for(:trial), :format => :js
      response.should render_template('trials/update')
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
