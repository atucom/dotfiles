#!/usr/bin/env ruby
#Ruby nessus search script
#@atucom


#check if the proper gems are installed
  [ 'rubygems','optparse','nessus' ].each {|required_gem|
    begin
      require required_gem
    rescue LoadError
      puts "You need to install the #{required_gem} gem to use this script"
      exit
    end
  }
#parse command line options
x=nil
options = {} #hash that hold the options
o=OptionParser.new do |opts|
   opts.banner = "Usage: #{$0} [options] ..." #the banner to display at the top
   optparse = OptionParser.new do|opts| #start defining options below
   opts.on( '-f', '--file File', 'The .nessus file to read from' ) {|i| options[:file] = i}
   opts.on( '-s', '--string asdf', 'The string to search for' ) {|i| options[:string] = i}
   opts.on( '-h', '--help', 'Display this screen' ) {puts opts; exit}
   x=opts
  end.parse!(ARGV)
end
if options[:file].nil?
 puts x
 exit
end

nessusfile = File.open(options[:file])
Nessus::Parse.new(nessusfile) do |scan|
    scan.each_host do |host|
        host.each_event do |event|
            if event.name =~/#{options[:string]}/
                puts "#{event.name},#{host.ip},#{event.port.number}"
            end
        end
    end
end

