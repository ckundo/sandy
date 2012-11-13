module Sandy::Provider
  module CoordinateCache

    def cached_coordinates_for area_name
      hsh = gps_data.fetch(area_name, {})
      return hsh.fetch(:latitude, nil), hsh.fetch(:longitude, nil)
    end

    def gps_data
      @gps_data ||= YAML.load(File.open(File.join(path, 'gps_data.yml')))
    end

  end
end