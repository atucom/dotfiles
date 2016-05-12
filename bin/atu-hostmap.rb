#!/usr/bin/env ruby
#get the CN of a cert and reverse resolve of an IP
require 'socket'
require 'openssl'
require 'resolv'

if ARGV.empty?
  puts "Pulls SSL Subject Name and reverse resolves an IP"
  puts "\t Usage: #{$0} IP:PORT"
  exit 1
end
ip = ARGV[0]
port = ARGV[1] || 443

def ssl_cert(ip, port)
  tcp_client = TCPSocket.new(ip, port)
  ssl_client = OpenSSL::SSL::SSLSocket.new(tcp_client).connect
  cert = OpenSSL::X509::Certificate.new(ssl_client.peer_cert)
  ssl_client.sysclose
  tcp_client.close
  return cert
end

def rresolve(ip)
  Resolv.getname(ip)
end

puts "#{ip} RESULTS:"
begin
print "  SSL - #{ip}:#{port} - "
cert = ssl_cert(ip,port)
cert.subject.to_s.scan(/CN=(.*)$/)
puts "#{$1}"
rescue Errno::ETIMEDOUT
  puts "  SSL - #{ip}:#{port} - ERROR: TIME OUT"
rescue Errno::ECONNREFUSED
  puts "  SSL - #{ip}:#{port} - ERROR: CONNECTION REFUSED"
rescue Errno::ECONNRESET
  puts "  SSL - #{ip}:#{port} - CONNECTION RESET BY SERVER"
end

begin
  rdnshost = rresolve ip
  puts "  DNS - #{ip}:#{port} - #{rdnshost}"
rescue Resolv::ResolvError
  puts "  DNS - #{ip} - ERROR: NO ENTRY"
end
