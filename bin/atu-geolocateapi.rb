#!/bin/env ruby
#@atucom

require 'net/https'
require 'uri'
require 'json'
require 'optparse'

#parse command line options
x=nil
options = {} #hash that hold the options
o=OptionParser.new do |opts|
   opts.banner = "Usage: #{$0} [options] --key APIKEY  MACADDR1 MACADDR2 ..." #the banner to display at the top
   opts.on( '-k', '--key APIKEY', 'Your google api key' ) {|i| options[:apikey] = i}
   opts.on( '-h', '--help', 'Display this screen' ) {puts opts; exit}
   x=opts
  end.parse!(ARGV)
if options[:apikey].nil?
 puts x
 exit
end

apikey = options[:apikey]
apiurl = "https://www.googleapis.com/geolocation/v1/geolocate?key=#{apikey}"
json = {"wifiAccessPoints"=>[]}

ARGV.each do |macaddr|
  json["wifiAccessPoints"] << {"macAddress"=>macaddr}
end

uri = URI.parse(apiurl)
headers = {'Content-Type' => "application/json"}
http = Net::HTTP.new(uri.host,uri.port)   # Creates a http object
http.use_ssl = true                                          # When using https
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
response = http.post(uri,JSON.generate(json),headers)

parsed_response = JSON.parse(response.body)

puts "#{parsed_response['location']['lat']}, #{parsed_response['location']['lng']}"