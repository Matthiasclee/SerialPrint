module SerialPrint
  module Serial
    def self.initialize(port, baud:9600)
      @ser = SerialPort.new(port, baud, 8, 1, SerialPort::NONE)

      loop do
        data = ""

        loop do
          byte = @ser.read(1)
          break if byte == "\f"
          data << byte if byte
        end

        data_as_html = <<-DATA
        <!DOCTYPE html>
        <html>
          <head>
            <title>Print Data</title>
              <style>
                body {
                  font-family: monospace;
                     }
              </style>
          </head>

          <body>
            <div>
              #{data
                .gsub("\r\n", "<br>")
                .gsub(" ", "&nbsp;")}
            </div>

            <script>
              print()
              let win = window.open(null, "_self");
              win.close();
            </script>
          </body>
        </html>
        DATA

        name = "tmp#{rand(1000000..9999999)}.html"
        File.write(name, data_as_html)

        start_command = $windows ? "start" : "firefox"
        `#{start_command} #{name}`
        sleep(5)
        File.delete(name)
      end
    end

    def self.detect_open_ports(baud:9600)
      port_number = 0
      10.times do |t|
        port_number = t
        begin
          p = SerialPort.new("COM#{t}", baud, 8, 1, SerialPort::NONE)
          p.close
          break
        rescue
          p = nil
        end
      end
      return "COM#{port_number}"
    end
  end
end
