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

        od_avg_data[iteration] = od.sum / 5
        os_avg_data[iteration] = os.sum / 5
      end


      return {
        od: od_data,
        os: os_data,
        od_avg: od_avg_data,
        os_avg: os_avg_data
      }
    end

    def self.make_graph(filename, graphname, datapoints)
      x = (1..datapoints.length).to_a
      y = datapoints

      dps = [y[0..3000], y[3001..4096]]

      2.times do |t|
        y = dps[t]

        Gnuplot.open do |gp|
          Gnuplot::Plot.new(gp) do |plot|
            plot.terminal 'jpeg size 640,430'
            plot.output "#{filename}_#{t+1}_of_2.jpg"
            plot.yrange "[0:256]"

            plot.unset "ytics"
            plot.unset "xtics"

            plot.margin "3,3,0.5,0.5"

            plot.data << Gnuplot::DataSet.new([x,y]) do |ds|
              ds.with = 'lines'
              ds.linecolor = "black"
              ds.title = "#{graphname} #{t+1}/2"
            end
          end
        end
      end
    end
  end
end
