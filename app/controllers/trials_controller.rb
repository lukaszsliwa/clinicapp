class TrialsController < ApplicationController
  before_filter :trial, :only => [:show, :destroy]

  def index
    @trials = Trial.order_by('created_at desc').page params[:page]
  end

  def new
    @trial = Trial.new
  end

  def show
  end

  def create
    @trial = Trial.create(params[:trial])
  end

  def destroy
    @trial.destroy
  end

  private

  def trial
    @trial ||= Trial.find(params[:id])
  end
end
