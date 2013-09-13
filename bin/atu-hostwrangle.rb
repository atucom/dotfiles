#!/usr/bin/env ruby

#check if the proper gems are installed
  { 'nmap' => 'ruby-nmap' }.each {|required_gem,gem_install|
    begin
      require required_gem
    rescue LoadError
      puts "You need to install the \'#{required_gem}\' gem to use this script"
      puts "You can do that by running \"gem install #{gem_install}\""
      exit
    end
  }


if ARGV.empty?
    puts "This script converts an nmap XML output file to easily grep/awkable format"
    puts "\t Usage: #{$0} file1.xml file2.xml file3.xml ... "
else
    ARGV.each do |args|
        #puts args
        Nmap::XML.new(args) do |xml| #take first argument as the xml file
          xml.each_host do |host| # iterate through all detected hosts in xml file
            host.each_port do |port| #for every port that is open, output the code block below
              puts "#{host.ip},#{port.number},#{port.protocol},#{port.state},#{port.service},#{port.service.product},#{port.service.version}"
            end
          end
        end
    end
end

