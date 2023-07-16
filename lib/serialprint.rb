module SerialPrint
end

$windows = (ARGV[1] == "windows")

require "serialport"
require "gnuplot"

require_relative "serialprint/serial.rb"
require_relative "serialprint/measurement_parser.rb"


if $windows && ARGV[0] == "auto"
  port = SerialPrint::Serial.detect_open_ports[-1]
else
  port = ARGV[0]
end

SerialPrint::Serial.initialize(port)
