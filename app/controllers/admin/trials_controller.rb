class Admin::TrialsController < ApplicationController
  before_filter :trial, :only => [:show, :edit, :update, :destroy]

  def index
    @trials = Trial.order_by('created_at desc').page params[:page]
  end

  def new
    @trial = Trial.new(:stop_on => 31.days.from_now)
  end

  def show
  end

  def create
    @trial = Trial.new
    @trial.assign_attributes(params[:trial], :as => :admin)
    respond_to do |format|
      if @trial.save
        format.html { redirect_to admin_trials_path }
      else
        format.html { render :action => :new}
      end
    end
  end

  def edit
  end

  def update
    @trial.assign_attributes(params[:trial], :as => :admin)
    respond_to do |format|
      if @trial.save
        format.html { redirect_to admin_trials_path }
      else
        format.html { render :action => :edit}
      end
    end
  end

  def destroy
    @trial.destroy
  end

  private

  def trial
    @trial ||= Trial.find(params[:id])
  end
end
