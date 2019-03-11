module ApiHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def do_request(method, api_path, options = {})
    send method, api_path, options
  end
end
