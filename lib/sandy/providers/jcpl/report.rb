module Sandy::Provider
  module JCPL
    class Report
      include Sandy::Provider::StormCenter
      attr_reader :areas

      def initialize
        raw_report = JSON.parse(HTTParty.get(jcpl_url))
        area_hash = raw_report.fetch("file_data")["curr_custs_aff"]["areas"].first["areas"]
        
        @areas = recursive_fetch_areas(
          area_hash, 
          ->(area) { area.fetch("areas", nil) } 
        )

      rescue
        raise LoadError, "JCPL response was not recognizable."
      end

      private

      def jcpl_url
        base_uri = "http://outages.firstenergycorp.com"
        directory_url = "#{base_uri}/data/interval_generation_data/metadataNJ.xml"
        response = HTTParty.get(directory_url, format: :xml)
        directory = response.parsed_response.fetch("root").fetch("directory")
        "#{base_uri}/data/interval_generation_data/#{directory}/report.js"
      end

    end
  end
end
