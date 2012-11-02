require "sandy/area"
require "httparty"
require "json"

module Sandy::Provider
  module ConEd
    class Report
      attr_reader :areas

      def initialize
        raw_report = JSON.parse(HTTParty.get(coned_url))
        @areas = areas_from_raw_report(raw_report)
      end

      private

      def areas_from_raw_report(raw_report)
        areas = raw_report.fetch("file_data").fetch("curr_custs_aff").fetch("areas").first.fetch("areas")
        areas.collect do |area|
          Sandy::Area.new(area.fetch("area_name"))
        end
      end

      def coned_url
        base_uri = "http://apps.coned.com"
        directory_url = "#{base_uri}/stormcenter_external/stormcenter_externaldata/data/interval_generation_data/metadata.xml"
        response = HTTParty.get(directory_url, format: :xml)
        directory = response.parsed_response.fetch("root").fetch("directory")
        "#{base_uri}/stormcenter_external/stormcenter_externaldata/data/interval_generation_data/#{directory}/report.js"
      end
    end
  end
end
