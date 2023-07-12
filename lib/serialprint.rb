module SerialPrint
end

require "serialport"

require_relative "serialprint/serial.rb"

SerialPrint::Serial.initialize("/dev/ttyS0")
