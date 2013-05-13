class TrialsController < ApplicationController
  before_filter :trial, :only => [:show, :edit, :update, :destroy]

  def index
    @trials = Trial.order_by('created_at desc').page params[:page]
  end

  def new
    @trial = Trial.new(:stop_on => 31.days.from_now)
    @trial.build_questions
  end

  def show
  end

  def create
    @trial = Trial.new
    @trial.assign_attributes(params[:trial], :as => :admin)
    @trial.save
  end

  def edit
  end

  def update
    @trial.assign_attributes(params[:trial], :as => :admin)
    @trial.save
  end

  def destroy
    @trial.destroy
  end

  private

  def trial
    @trial ||= Trial.find(params[:id])
  end
end
