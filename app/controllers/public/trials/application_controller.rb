class Public::Trials::ApplicationController < Public::ApplicationController
  before_filter :trial

  def trial
    @trial ||= Trial.find(params[:trial_id])
  end
end
