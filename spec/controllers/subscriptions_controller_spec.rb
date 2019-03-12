require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user)     { create(:user) }
  let(:question) { create(:question) }

  describe 'POST #create' do
   let(:subscribed) { post :create, params: { subscription: { user: user, question: question } }, format: :js }

   it 'unauthenticated user unable subscribed' do
     subscribed

     expect(response).to be_forbidden
   end

   before { login(user) }

   it 'status successful' do
     subscribed

     expect(response).to be_successful
   end

   it 'subscribed change Subscription count'do
     expect { subscribed }.to change(Subscription, :count).by(1)
   end

    it 'render template' do
      subscribed

      expect(response).to render_template :create
    end
  end

  describe 'DELETE #destroy' do
    let(:unsubscribed) { delete :destroy, params: { id: subscription }, format: :js }

    before { login(user) }

    it 'unsubscribed change Subscription count'do
      expect { unsubscribed }.to change(Subscription, :count).by(-1)
    end
  end
end
