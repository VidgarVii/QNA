require 'rails_helper'

RSpec.describe NotificationAnsweredJob, type: :job do
  let(:user)   { create(:user) }

  it 'calls NotificationAnsweredMailer#notify' do
    expect(NotificationAnsweredMailer).to receive(:notify).with(user)

    NotificationAnsweredJob.perform_now(user)
  end
end
