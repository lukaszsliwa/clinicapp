class QuestionsController < ApplicationController
  before_filter :question, :only => [:edit, :update, :destroy]

  def index
    @questions = Question.order_by('created_at desc').page params[:page]
  end

  def new
    @question = Question.new :type => 'text'
  end

  def create
    @question = Question.create(params[:question])
  end

  def edit
  end

  def update
    @question.update_attributes(params[:question])
  end

  def destroy
    @question.destroy
  end

  private

  def question
    @question ||= Question.find(params[:id])
  end
end
