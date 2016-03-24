#!/usr/bin/env ruby
#vnc-info like script that has support for 4.x RFB versions (doesnt matter what version number it is)
#metasploit and nmap seem to crap themselves on 4.x VNC versions
#i really only care about none auth so thats what i'm checking for
#caveat: if the server forces encryption and still has no password, none auth will not show up
#as a valid authentication type. usually the only one that shows up is RA2 which i still have to implement
#in any case, its still better then running away scared at anything 4.x

require 'io/nonblock'
require 'socket'  
require 'optparse'
#require 'pry'
#require 'pp'
#parse command line options
x=nil
options = {} #hash that hold the options
o=OptionParser.new do |opts|
   opts.banner = "Usage: #{File.basename($0)} [options] ..." #the banner to display at the top
   optparse = OptionParser.new do|opts| #start defining options below
   opts.on( '-t', '--target TARGET', 'Target hostname or IP' ) {|i| options[:target] = i}
   options[:port] = 5900
   opts.on( '-p', '--port PORT', 'Port number VNC service is listening on' ) {|i| options[:port] = i}
   opts.on( '-h', '--help', 'Display this screen' ) {puts opts; exit}
   x=opts
  end.parse!(ARGV)
end

if options[:target].nil?
    puts "its nil"
 puts x
 exit
end
########################################################################################################
rfb33 = "RFB 003.003\n"
rfb37 = "RFB 003.007\n"
rfb38 = "RFB 003.008\n"
rfb41 = "RFB 004.001\n"
rfb_version = rfb41
hostname = options[:target]
port = options[:port]

#must have format of 'RFB 00x.00y\n'
def valid_banner?(banner)
    banner =~ /^RFB ([0-9]{3})\.([0-9]{3})\n$/ ?  true :  false
end

#returns TCPSocket object to read and write to
def rfbconnect(hostname,port)
    return TCPSocket.open(hostname, port)
end

def readbuff(tcpsocket_object)
    tcpsocket_object.read_nonblock(65535)
end

def noneauth?(security_types)
    security_types =~ /\x01/ ? true: false
end

def valid_security_type_length?(security_types)
    security_types.unpack('C')[0] == security_types.length - 1 ? true : false
end

def send_client_banner(tcpsocket_object, rfb_version)
    tcpsocket_object.write(rfb_version)
end
###########################################################
s = rfbconnect(hostname,port)
banner = s.gets
if valid_banner?(banner)
    print  "#{hostname}:#{port} -- #{banner.chop}"
else
    puts "#{hostname}:#{port} -- FATAL [Did not detect valid VNC protocol banner]"
    exit 1
end
#s.write(rfb_version)
send_client_banner(s,rfb_version)
sleep 1 #you have to wait for the traffic to come
sectypes = readbuff s
if valid_security_type_length?(sectypes) and noneauth?(sectypes)
    puts " :: NoneAuth"
end
s.close
#binding.pry
