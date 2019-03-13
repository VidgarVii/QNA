require 'rails_helper'

RSpec.describe Services::NotifySubscribers do
  let!(:users) { create_list(:user, 5) }
  let(:question) { create(:question) }
  subject { Services::NotifySubscribers.new(question) }

  before do
    users.each do |user|
      question.subscribed.create!(user: user)
    end
  end

  it 'send mail to all users' do
    users.each do |user|
      p user.email
      expect(NotifySubscriberMailer).to receive(:send_mail).with(user.email, question.title).and_call_original
    end

    subject.notify
  end
end
