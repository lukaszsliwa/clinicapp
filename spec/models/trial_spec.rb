require 'spec_helper'

describe Trial do
  describe '#name' do
    context 'when name is blank' do
      subject { build(:trial, :name => nil) }
      it 'should not create a trial' do
        expect {
          subject.save
        }.to_not change(Trial, :count).by(1)
      end
    end
  end
  describe '.active' do
    context 'with default parameter' do
      context 'when exists open trial' do
        before do
          @trial1 = create(:trial, :type => :start_stop, :start_on => DateTime.yesterday, :stop_on => DateTime.tomorrow)
          @trial2 = create(:trial, :type => :closed, :start_on => 2.days.ago, :stop_on => 1.day.ago)
        end
        it 'should return a trial' do
          Trial.active.all.to_a.should eql [@trial1]
        end
      end
      context 'when does not exist a trial' do
        it 'should not return a trial' do
          Trial.active.all.to_a.should eql []
        end
      end
    end
  end
end
