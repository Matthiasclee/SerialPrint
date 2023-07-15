module SerialPrint
  module MeasurementParser
    def self.parse_data(data)
      measurement_data = data.split("\r\n\r\n")[-1].split("\r\n")
      measurement_data.delete_at(0)
      measurement_data.delete_at(0)

      return measurement_data.join("\r\n")
    end
  end
end
