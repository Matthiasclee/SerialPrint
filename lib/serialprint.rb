module SerialPrint
end

require "serialport"

require_relative "serialprint/serial.rb"

SerialPrint::Serial.initialize(ARGV[0])
