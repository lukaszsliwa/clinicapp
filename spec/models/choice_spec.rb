require 'spec_helper'

describe Choice do
  subject{ create(:choice, :choiceable => create(:trial)) }
  describe '#copy_question_text' do
    it 'should copy question text' do
      subject.question_text.should eql subject.question.text
    end
  end
  describe '#eligible?' do
    context 'when suggested value is blank' do
      before do
        subject.suggested_value = nil
      end
      its(:eligible?) { should be_true }
    end
    context 'when patient value is the same as suggested value' do
      before do
        subject.suggested_value = subject.patient_value = 10
      end
      its(:eligible?) { should be_true }
    end
    context 'when patient value is different' do
      before do
        subject.suggested_value = 1
        subject.patient_value = 10
      end
      its(:eligible?) { should be_false }
    end
  end
end
