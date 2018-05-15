class TimeHandler
  attr_reader :time, :unknown

  FORMATS = { 'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
              'hour' => '%H:', 'minute' => '%M:', 'second' => '%S' }

  def initialize(params)
    @valid_format = ''
    @unknown = []
    @time = ''
    time_format(params)
  end

  def success?
     @unknown.empty?
  end

  private

  def time_format(params)
    if params['format']
      check_parameters(params['format'].split(','))
    end
  end

  def check_parameters(parameters)
    parameters.each do |format|
      if FORMATS[format]
        @valid_format += FORMATS[format]
      else
        @unknown << format
      end
    end

    @time = Time.now.strftime(@valid_format)
    @time += "\n"
  end
end
