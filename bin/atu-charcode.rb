#!/usr/bin/env ruby
require 'optparse' #command line options parser
options = {} #hash that hold the options
optparse = OptionParser.new do|opts|
   opts.banner = "Converts ASCII text input to JS Charcodes"
   opts.banner += "\n  Usage: #{File.basename($0)} [-h|-d delim] 'MYRANDOMTEXT'..." #the banner to display at the top
   options[:delim] = ','
   opts.on( '-d', '--delim delimiter', 'The delimiter to join the charcodes. Default: ,' ) do|option|
     options[:delim] = option
   end
   opts.on( '-h', '--help', 'Display this screen' ) do
     puts opts
   end
   if ARGV.empty?
    puts opts
    exit 1
  end
 end.parse!(ARGV)


if not STDIN.tty? and not STDIN.closed?
  input = STDIN.read
else
  input = ARGV[0] || ""
end

unless input.empty?
  delimiter = options[:delim]
  puts input.chars.map(&:ord).join (delimiter)
else
  puts optparse
end