module SerialPrint
end

$windows = (ARGV[1] == "windows")

require "serialport"

require_relative "serialprint/serial.rb"

SerialPrint::Serial.initialize(ARGV[0])
