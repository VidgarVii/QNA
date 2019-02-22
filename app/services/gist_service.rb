class GistService
  attr_reader :status

  def initialize(url)
    @id       = extract_id(url)
    @response = call
  end

  def content
    gist_found? ? get_context.content : @status
  end

  def gist_found?
    @status == 200
  end

  private

  def call
    @status = 200
    http_client.gist(@id)
  rescue Octokit::NotFound => error
    @status = error.response_status
  end

  def http_client
    Octokit::Client.new(access_token: ENV['TOKEN_GITHUB_GIST'])
  end

  def get_context
    @response.files.each do |key, file|
      @context = file
    end

    @context
  end

  def extract_id(url)
    id = url.split('/').reject(&:blank?)[-1]
    id.include?('#') ? id.split('#')[0] : id
  end
end
