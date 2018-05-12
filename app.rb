require_relative 'time_handler'

class App
  def call(env)
    @request = Rack::Request.new(env)
    if @request.path_info == '/time'
      time = TimeHandler.new(@request.params)
      response(time.status, headers, [time.response])
    else
      response(404, headers, ["Not Found\n"])
    end
  end

  private

  def response(status, headers, body)
    [ status, headers, body ]
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end
end
