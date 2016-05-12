#!/usr/bin/env ruby
require 'webrick'
require 'webrick/https'
require 'optparse'

options = {}
optparse = OptionParser.new do|opts|
   opts.banner = "Usage: #{$0} [options] ..." 
   opts.on( '-p', '--port PORT', 'The port to listen on. Default:8443' ) do|port|
     options[:port] = port
   end
   opts.on( '-d', '--docroot PATH', 'The directory to serve. Default: Current Dir' ) do|docroot|
     options[:docroot] = docroot
   end
   opts.on( '-h', '--help', 'Display this screen' ) do
     puts opts
     exit 1
   end
 end.parse!(ARGV)

docroot = options[:docroot] || '.'
port = options[:port] || 8443
cert_name = [
  %w[CN localhost],
]
server = WEBrick::HTTPServer.new(:Port => port,
                                 :SSLEnable => true,
                                 :DocumentRoot => File.expand_path(docroot),
                                 :SSLCertName => cert_name) #this will be a self signed cert

trap 'INT' do server.shutdown end
puts "Serving #{docroot} on port #{port}"
server.start