require 'rails_helper'

RSpec.describe NotificationAnsweredJob, type: :job do
  let(:user)   { create(:user) }

  it 'calls NotificationMailer#notify' do
    expect(NotificationMailer).to receive(:notify).with(user)

    NotificationAnsweredJob.perform_now(user)
  end
end
