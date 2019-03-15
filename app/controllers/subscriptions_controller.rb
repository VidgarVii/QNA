class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize! :create, Subscription

    question = Question.find(params[:question_id])
    @subscription = question.subscriptions.create(user: current_user)
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
