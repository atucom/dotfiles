#!/usr/bin/env ruby
#get the CN of a cert and reverse resolve of an IP
require 'socket'
require 'openssl'
require 'resolv'

if ARGV.empty?
  puts "Pulls SSL Subject Name and reverse resolves an IP"
  puts "\t Usage: #{$0} IP PORT"
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
  cert = ssl_cert(ip,port) 
  print "  SSL - #{ip}:#{port} - "
  cert.subject.to_s.scan(/CN=(.*)$/)
  puts "#{$1}"
  #Adding in Subject Alt Name grab from cert
  subject_alt_name = cert.extensions.find {|e| e.oid == "subjectAltName"}
  asn_san = OpenSSL::ASN1.decode(subject_alt_name)
  asn_san_sequence = OpenSSL::ASN1.decode(asn_san.value[1].value)
  asn_san_sequence.each do |asn_data|
    puts "  SSL/SAN - #{ip}:#{port} - " + asn_data.value
  end
rescue Errno::ETIMEDOUT
  puts "  SSL - #{ip}:#{port} - ERROR: TIME OUT"
rescue Errno::ECONNREFUSED
  puts "  SSL - #{ip}:#{port} - ERROR: CONNECTION REFUSED"
rescue Errno::ECONNRESET
  puts "  SSL - #{ip}:#{port} - CONNECTION RESET BY SERVER"
end

begin
  rdnshost = rresolve ip
  puts "  DNS - #{ip} - #{rdnshost}"
rescue Resolv::ResolvError
  puts "  DNS - #{ip} - ERROR: NO ENTRY"
end
