require_relative 'time_handler'

class App
  def call(env)
    @request = Rack::Request.new(env)
    if @request.path_info == '/time'
      time_handler = TimeHandler.new(@request.params)

      return response(400, headers, "The format parameter is empty\n") if format_failed?

      if time_handler.success?
        response(200, headers, time_handler.time)
      else
        response(400, headers, "Unknown time format #{time_handler.unknown.join ', '}\n")
      end

    else
      response(404, headers, "Not Found\n")
    end
  end

  private

  def format_failed?
    @request.params['format'].nil?
  end

  def response(status, headers, body)
    [ status, headers, [body] ]
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end
end
