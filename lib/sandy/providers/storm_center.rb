module Sandy::Provider
  module StormCenter
  
    def recursive_fetch_areas report_areas, sub_select_func, parent=nil
        if report_areas
          arr = []
            report_areas.each do |report_area|
              begin

                children = 
                options = {
                  parent: parent,
                  total_customers: report_area.fetch("total_custs", 0).to_i,
                  estimated_recovery_time: report_area.fetch("etr", nil),
                  latitude: report_area.fetch("latitude", nil),
                  longitude: report_area.fetch("longitude", nil),
                  children: recursive_fetch_areas(sub_select_func.call(report_area), sub_select_func, report_area)
                }

                arr.push Sandy::Area.new(report_area.fetch("custs_out", 0).to_i, report_area.fetch("area_name", nil), options)
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

  end
end