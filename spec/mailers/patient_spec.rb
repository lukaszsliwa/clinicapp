require "spec_helper"

describe PatientMailer do
  let(:patient) { create(:patient) }

  it 'should send reminder' do
    PatientMailer.remind(patient).deliver
  end
end
