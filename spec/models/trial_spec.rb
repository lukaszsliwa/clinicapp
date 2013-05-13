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
  describe '.open' do
    context 'with default parameter' do
      context 'when exists open trial' do
        before do
          @trial1 = create(:trial, :start_on => DateTime.yesterday, :stop_on => DateTime.tomorrow)
          @trial2 = create(:trial, :start_on => 2.days.ago, :stop_on => 1.day.ago)
        end
        it 'should return a trial' do
          Trial.open.all.to_a.should eql [@trial1]
        end
      end
      context 'when does not exist a trial' do
        it 'should not return a trial' do
          Trial.open.all.to_a.should eql []
        end
      end
    end
  end
  describe '#build_questions' do
    before do
      @question1 = create(:question)
      @question2 = create(:question)
      @trial = build(:trial)
    end
    it 'should build two questions for the trial' do
      expect {
        @trial.build_questions
      }.to change { @trial.choices.size }.from(0).to(2)
    end
  end
end
