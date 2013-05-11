class Public::TrialsController < Public::ApplicationController
  def index
    @trials = Trial.open.all
  end
end
