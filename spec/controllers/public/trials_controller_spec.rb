require 'spec_helper'

describe Public::TrialsController do
  before do
    @trial = create(:trial, :type => :start_stop, :start_on => 7.days.from_now, :stop_on => 14.days.from_now)
    @trial1 = create(:trial, :type => :start_stop, :start_on => 1.day.ago, :stop_on => 7.days.from_now)
    @trial2 = create(:trial, :type => :start_stop, :start_on => 7.days.ago, :stop_on => 1.day.from_now)
  end
  describe '#index' do
    it 'should get open trials' do
      get :index
      assigns(:trials).to_a.should eql [@trial1, @trial2]
    end
  end
end
