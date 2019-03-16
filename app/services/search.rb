class Services::Search
  CHECKS = %w[answer question comment user].freeze

  def result(params)
    @params = params
    search
  end

  private

  def search
    result = []
    CHECKS.each do |key|
      result << (make_klass(key)) if @params[key] == '1'
    end

    ThinkingSphinx.search query_string, classes: result, page: @params[:page], per_page: 10
  end

  def query_string
    ThinkingSphinx::Query.escape(@params['q']) if @params['q']
  end

  def make_klass(key)
    key.classify.constantize
  end
end
