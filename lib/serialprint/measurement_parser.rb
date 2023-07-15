module SerialPrint
  module MeasurementParser
    def self.parse_data(data)
      measurement_data = data.split("\r\n\r\n")[-1].split("\r\n")
      measurement_data.delete_at(0)
      measurement_data.delete_at(0)

      od_data = [
        [],
        [],
        [],
        [],
        []
      ]

      os_data = [
        [],
        [],
        [],
        [],
        []
      ]

      od_avg_data = []
      os_avg_data = []


      measurement_data.each_with_index do |line, iteration|
        od = line.split(" ")[0..4].map{|x|x.to_i}
        os = line.split(" ")[5..9].map{|x|x.to_i}

        od.each_with_index do |m, i|
          od_data[i][iteration]=m
        end

        os.each_with_index do |m, i|
          os_data[i][iteration]=m
        end

        od_avg_data = od.sum / 5
        os_avg_data = os.sum / 5
      end


      return {
        od: od_data,
        os: os_data,
        od_avg: od_avg_data,
        os_avg: os_avg_data
      }
    end
  end
end
