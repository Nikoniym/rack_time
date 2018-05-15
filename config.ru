require_relative 'app'
require_relative 'middleware/logger'

use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run App.new
