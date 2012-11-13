require 'xml'

module Sandy::Provider
  module PSEG
    class Report
      include Sandy::Provider::CoordinateCache

      attr_reader :areas

      def initialize
        parser = XML::Parser.new
        parser.string = HTTParty.get(pseg_url).to_s
        raw_report = parser.parse

        @areas = parse raw_report
        
      rescue
        raise LoadError, "PSEG response was not recognizable."
      end

      private 

      def parse raw_report
        arr = []
        raw_report.find('//ms:polygon').each do |p|
          begin
            name = p.find_first('ms:county').content.to_s
            customers_affected = p.find_first('ms:outage').content.to_s

            latitude, longitude = cached_coordinates_for report_area

            options = {
              :latitude => latitude,
              :longitude => longitude
            }
            arr << Sandy::Area.new(customers_affected, name, options)
          rescue
            # FIXME: raise warning if any region is empty.
            next
          end
        end
        arr
      end

      def pseg_url
        'http://www.pseg.com/outagemap/Customer%20Outage%20Application/Web%20Pages/GML/State.gml'
      end

      def path
        File.dirname(__FILE__)
      end
    end
  end
end