#!/usr/bin/env ruby
require 'optparse' #command line options parser
options = {} #hash that hold the options
optparse = OptionParser.new do|opts|
   opts.banner = "Usage: #{$0} [options] ..." #the banner to display at the top
   options[:delim] = ','
   opts.on( '-d', '--delim delimiter', 'The delimiter to join the charcodes. Default: ,' ) do|option|
     options[:delim] = option
   end
   # This displays the help screen, all programs are
   # assumed to have this option.
   opts.on( '-h', '--help', 'Display this screen' ) do
     puts opts
   end
 end.parse!(ARGV)


input = ARGV[0]
delimiter = options[:delim]
puts input.chars.map(&:ord).join (delimiter)