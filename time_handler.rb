class TimeHandler
  attr_reader :status, :response
  FORMATS = { 'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
              'hour' => '%H:', 'minute' => '%M:', 'second' => '%S' }

  def initialize(params)
    @valid_format = ''
    @unknown = []
    @response = time_format(params)
  end

  private

  def time_format(params)
    if params['format']
      check_parameters(params['format'].split(','))
    else
      return parameter_empty
    end

    if @unknown.empty?
      time_output
    else
      unknown_format
    end
  end

  def parameter_empty
    @status = 400
    "The format parameter is empty\n"
  end

  def unknown_format
    @status = 400
    "Unknown time format #{@unknown.join ', '}\n"
  end

  def time_output
    @status = 200
    Time.now.strftime(@valid_format)
  end

  def check_parameters(parameters)
    parameters.each do |format|
      if FORMATS[format]
        @valid_format += FORMATS[format]
      else
        @unknown << format
      end
    end
  end
end
