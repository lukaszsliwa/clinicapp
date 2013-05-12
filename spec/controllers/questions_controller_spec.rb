require 'spec_helper'

describe QuestionsController do
  before do
    @question = create(:question)
  end
  describe '#index' do
    it 'should get the list' do
      get :index, :page => 1
      response.should render_template('questions/index')
      assigns(:questions).to_a.should eql [@question]
    end
  end
  describe '#new' do
    it 'should get new question' do
      get :new, :format => :js
      assigns(:question).new_record?.should be_true
      assigns(:question).type.should eql :text
    end
  end
  describe '#create' do
    it 'should create question' do
      expect {
        post :create, :question => attributes_for(:question), :format => :js
        response.should render_template('questions/create')
      }.to change(Question, :count).by 1
    end
  end
  describe '#update' do
    it 'should update question' do
      put :update, :id => @question, :question => attributes_for(:question), :format => :js
      response.should render_template('questions/update')
    end
  end
  describe '#destroy' do
    it 'should destroy question' do
      expect {
        delete :destroy, :id => @question, :format => :js
        response.should render_template('questions/destroy')
      }.to change(Question, :count).by -1
    end
  end
end
