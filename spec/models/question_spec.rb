require 'spec_helper'

describe Question do
  let(:trial) { create(:trial) }
  subject { create(:choices_question, :questionable => trial) }
  describe '#clear_choices' do
    it 'should clear choices' do
      expect {
        subject.clear_choices
      }.to change(subject, :choices).to([])
    end
  end
  describe '#remove_blank_choices' do
    before do
      subject.choices = ['', 'A', '', 'B', '', '']
    end
    it 'should clear choices' do
      expect {
        subject.remove_blank_choices
      }.to change(subject, :choices).to(%w{A B})
    end
  end
end
