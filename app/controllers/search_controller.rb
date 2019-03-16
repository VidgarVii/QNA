class SearchController < ApplicationController
  def search
    @result = service.result(search_params)
  end

  private

  def service
    @service ||= Services::Search.new
  end

  def search_params
    params.permit(%i[q question answer comment user page])
  end
end
