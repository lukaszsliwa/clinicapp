require 'spec_helper'

describe Patient do
  describe '#copy_choices_from_trial' do
    let(:trial) { create(:trial_with_choices) }
    subject{ create(:patient, :trial => trial) }
    it 'should copy choices from trial' do
      subject.choices.all.map{|c| c.id = nil; c}.should eql trial.choices.all.map{|c| c.id = nil; c}
    end
  end
  describe '#generate_token' do
    subject{ create(:patient, :token => nil) }
    its(:token) { should be_present }
  end
  describe '#eligible_now?' do
    let(:trial) { create(:trial_with_choices) }
    subject{ create(:patient, :trial => trial) }
    context 'when all choices are eligible' do
      before do
        Choice.any_instance.stubs(:eligible?).returns(true)
      end
      its(:eligible_now?) { should be_true }
    end
    context 'when some choices are not eligible' do
      before do
        Choice.any_instance.stubs(:eligible?).returns(false)
      end
      its(:eligible_now?) { should be_false }
    end
  end
  describe '#eligible!' do
    subject{ create(:not_eligible_patient) }
    context 'when eligible now returns true' do
      before do
        Patient.any_instance.expects(:eligible_now?).once.returns(true)
      end
      it 'should set eligible on true' do
        expect {
          subject.eligible!
        }.to change(subject, :eligible).from(false).to(true)
      end
    end
    context 'when eligible now returns false' do
      before do
        Patient.any_instance.expects(:eligible_now?).once.returns(false)
      end
      it 'should set eligible on false' do
        expect {
          subject.eligible!
        }.to_not change subject, :eligible
      end
    end
  end
  describe '#finish!' do
    subject{ create(:not_finished_patient) }
    before do
      Patient.any_instance.expects(:eligible!).once
    end
    it 'should finish' do
      expect {
        subject.finish!
      }.to change(subject, :finished).from(false).to(true)
    end
  end
  describe '.remind_if_not_finished' do
    before do
      @patient1 = create(:not_finished_patient, :created_at => Date.yesterday)
      @patient2 = create(:not_finished_patient, :created_at => Date.yesterday)
      @patient3 = create(:not_finished_patient)
      PatientMailer.remind(@patient1).deliver
      PatientMailer.remind(@patient2).deliver
      @mail = mock('mail')
      @mail.stubs(:deliver => true)
    end
    it 'should send reminder' do
      PatientMailer.expects(:remind).with(@patient1).returns @mail
      PatientMailer.expects(:remind).with(@patient2).returns @mail
      Patient.remind_if_not_finished
    end
  end
end
