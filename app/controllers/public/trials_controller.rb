class Public::TrialsController < Public::ApplicationController
  def index
    @trials = Trial.active.all
  end
end
