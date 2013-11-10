## Disclaimer
11/10/13 - I have not been maintaining this gem, and I'm not sure that the Coned endpoints are still available. *It may not work as expected*.

# Sandy 
[![Build Status](https://secure.travis-ci.org/ckundo/sandy.png)](https://travis-ci.org/ckundo/sandy)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/ckundo/sandy)

Sandy is a rubygem for consuming power outage data for the Greater New York area. For a given area, retrieve number of outages,
as well as total customers, lat/lng, and estimated time of recovery (depending on the provider). 

Currently supports ConEd (NYC), LIPA (Long Island), and PSEG (NJ).

## Usage

### Providers
    
    Sandy::Provider::LIPA::Report.new
    Sandy::Provider::ConEd::Report.new

### Areas

    Area#name
    Area#customers_affected
    Area#region
    Area#latitude
    Area#longitude
    Area#total_customers
    Area#estimated_recovery_time

### Example

    report = Sandy::Provider::ConEd::Report.new

    areas = report.areas
    areas.each do |area|
      puts "#{area.name}, #{area.customers_affected}"
    end

    # => 

    Bronx, 28644
    Brooklyn, 37016
    Manhattan, 226225
    Queens, 85057
    Staten Island, 58043
    Westchester, 123571

### A note on Polling

The ConEd outage feed is only updated every 15 minutes. Repeated polling won't get you new results.

## Installation

Add this line to your application's Gemfile:

    gem 'sandy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sandy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Powered by the sandy gem

* [NYC Power Status](http://nycpowerstatus.com/) - vizualizations of power outages by neighborhood in NYC
