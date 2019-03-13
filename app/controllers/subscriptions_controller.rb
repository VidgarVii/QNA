class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize! :create, Subscription

    @subscription = current_user.subscriptions.build(subscription_params)
    @subscription.save
  end

  def destroy
    authorize! :destroy, subscription

    subscription.destroy
  end

  private

  helper_method :question, :subscription

  def question
    @question ||= subscription.question
  end

  def subscription_params
    params.permit(:question_id)
  end

  def subscription
    @subscription ||= Subscription.find(params[:id])
  end
end
