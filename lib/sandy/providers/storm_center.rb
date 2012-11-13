module Sandy::Provider
  module StormCenter
    include Sandy::Provider::CoordinateCache
 
    def recursive_fetch_areas report_areas, sub_select_func, parent=nil
      if report_areas
        arr = []
          report_areas.each do |report_area|
            begin

              latitude, longitude = cached_coordinates_for(report_area['area_name'].downcase)

              options = {
                parent: parent,
                total_customers: report_area.fetch("total_custs", 0).to_i,
                estimated_recovery_time: report_area.fetch("etr", nil),
                latitude: latitude,
                longitude: longitude,
                children: recursive_fetch_areas(sub_select_func.call(report_area), sub_select_func, report_area)
              }

              arr.push Sandy::Area.new(report_area.fetch("custs_out", 0).to_i, sanitize_name(report_area.fetch("area_name", nil)), options)
            rescue
              # FIXME: raise warning if any region is empty.
              next
            end
          end
        arr
      else
        []
      end
    end

    def sanitize_name str
      str.split(' ').map {|w| w.downcase.capitalize }.join(' ')
    end

  end
end