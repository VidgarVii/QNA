require 'rails_helper'

describe NotifySubscribersJob, type: :job do
  let(:service)  { double('Service::NotifySubscribers') }
  let(:question) { create(:question) }

  before do
    allow(Services::NotifySubscribers).to receive(:new).with(question).and_return(service)
  end

  it 'calls Service::DailyDigest#send_digest' do
    expect(service).to receive(:notify)
    NotifySubscribersJob.perform_now(question)
  end
end
