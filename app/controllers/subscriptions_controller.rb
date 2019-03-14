class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize! :create, Subscription

    @subscription = current_user.subscriptions.create(question_id: params[:question_id])
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

  def subscription
    @subscription ||= Subscription.find(params[:id])
  end
end

