module SerialPrint
  module Serial
    def self.initialize(port, baud:9600)
      @ser = SerialPort.new(port, baud, 8, 1, SerialPort::NONE)

      data = ""

      loop do
        byte = @ser.read(1)
        break if byte == "\f"
        data << byte
      end

      STDOUT.puts data
    end
  end
end
