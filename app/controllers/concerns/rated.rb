module Rated
  extend ActiveSupport::Concern

  def rating_up
    respond_to do |format|
      if object.rate_up
        format.json { render json: object.rating }
      else
        format.json do
          render json: object.rate,
                 status: :forbidden
        end
      end
    end
  end

  def rating_down
    respond_to do |format|
      if object.rate_down
        format.json { render json: object.rating }
      else
        format.json do
          render json: object.rate,
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
