module Rated
  extend ActiveSupport::Concern

  def rating_up
    if object.rate_up(current_user)
      render json: object.rating
    else
      render json: {access: 'No access'}, status: :forbidden
    end
  end

  def rating_down
    respond_to do |format|
      if object.rate_down(current_user)
        format.json { render json: object.rating }
      else
        format.json do
          render json: {access: 'No access'},
                 status: :forbidden
        end
      end
    end
  end

  private

  def object
    make_klass.find(params[:id])
  end

  def make_klass
    controller_name.classify.constantize
  end
end
