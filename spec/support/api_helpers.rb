# frozen_string_literal: true

module ApiHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def do_request(method, path, headers = {})
    send method, path, headers: headers
  end
end
