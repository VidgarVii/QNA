require "rails_helper"

RSpec.describe NotifySubscriberMailer, type: :mailer do
  describe "send_mail" do
    # let(:user) { create(:user) }
    let(:mail) { NotifySubscriberMailer.send_mail('user@email.ru', 'Title') }

    it "renders the headers" do
      expect(mail.subject).to eq("News for question")
      expect(mail.to).to eq(['user@email.ru'])
      expect(mail.from).to eq(["from@example.com"])
    end
  end
end
