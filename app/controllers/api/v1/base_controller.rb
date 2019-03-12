class Api::V1::BaseController < ApplicationController
  before_action :doorkeeper_authorize!

  private

  def current_resource_owner
    @current_resource_owner ||= User.find(current_resource_owner_id) if doorkeeper_token
  end

  def current_resource_owner_id
    doorkeeper_token.resource_owner_id
  end

  def current_ability
    @current_ability ||= Ability.new(current_user || current_resource_owner)
  end
end
