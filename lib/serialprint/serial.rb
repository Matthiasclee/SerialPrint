module SerialPrint
  module Serial
    def self.initialize(port, baud:115200)
      @ser = SerialPort.new(port, baud, 8, 1, SerialPort::NONE)

      loop do
        data = ""

        extradata = ""

        loop do
          byte = @ser.read(1)
          break if byte == "\f"
          data << byte if byte
        end

        loop do
          byte = @ser.read(1)
          break if byte == "\f"
          extradata << byte if byte
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

        parsed_data = MeasurementParser.parse_data extradata
        MeasurementParser.make_graph("OD_1", "OD 1", parsed_data[:od][0])
        MeasurementParser.make_graph("OS_1", "OS 1", parsed_data[:os][0])

        MeasurementParser.make_graph("OD_2", "OD 2", parsed_data[:od][1])
        MeasurementParser.make_graph("OS_2", "OS 2", parsed_data[:os][1])

        MeasurementParser.make_graph("OD_3", "OD 3", parsed_data[:od][2])
        MeasurementParser.make_graph("OS_3", "OS 3", parsed_data[:os][2])

        MeasurementParser.make_graph("OD_4", "OD 4", parsed_data[:od][3])
        MeasurementParser.make_graph("OS_4", "OS 4", parsed_data[:os][3])

        MeasurementParser.make_graph("OD_5", "OD 5", parsed_data[:od][4])
        MeasurementParser.make_graph("OS_5", "OS 5", parsed_data[:os][4])

        MeasurementParser.make_graph("OD_avg", "OD Average", parsed_data[:od_avg])
        MeasurementParser.make_graph("OS_avg", "OS Average", parsed_data[:os_avg])
        STDOUT.puts "Done"
      end
    end

    def self.detect_open_ports(baud:115200)
      ports = []
      10.times do |t|
        begin
          p = SerialPort.new("COM#{t}", baud, 8, 1, SerialPort::NONE)
          ports << t
          p.close
        rescue
          p = nil
        end
      end
      return ports.map {|a| "COM#{a}"}
    end
  end
end
