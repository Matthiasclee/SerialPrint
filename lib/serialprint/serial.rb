module SerialPrint
  module Serial
    def self.initialize(port, baud:9600)
      @ser = SerialPort.new(port, baud, 8, 1, SerialPort::NONE)

      loop do
        STDOUT.print @ser.read(1)
      end
    end
  end
end
