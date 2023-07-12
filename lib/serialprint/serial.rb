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

      data_as_html = <<-DATA
        <!DOCTYPE html>
        <html>
          <head>
            <title>Printed Data</title>
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
      `firefox #{name}`
      sleep(5)
      File.delete(name)
    end
  end
end
