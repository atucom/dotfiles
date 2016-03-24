#!/usr/bin/env ruby
#ftp dir list
#Goal: list out the directory contents of ftp servers, given a certain login
#@atucom 2013
#TODO LIST
#   Get the domain name or netbios name
#   Output if the server is running http

require 'optparse'
require 'net/ftp'

#parse command line options
x=nil
options = {} #hash that hold the options
optparse = OptionParser.new do |opts| #start defining options below
  opts.banner = "Lists files in FTP root
  Usage: #{File.basename($0)} [options]" #the banner to display at the top
  opts.on( '-t', '--target HOST', 'The target FTP server' ) {|i| options[:target] = i}
  opts.on( '-p', '--port PORT', 'The target port' ) {|i| options[:port] = i}
  opts.on( '-u', '--user USERNAME', 'The username to login with (default: anonymous)' ) {|i| options[:username] = i}
  opts.on( '-P', '--password PASSWORD', 'The password to login with' ) {|i| options[:password] = i}
  opts.on( '-g', '--grepable', 'Print result in grepable output' ) {options[:grepable] = 1}
  opts.on( '-h', '--help', 'Display this screen' ) {puts opts; exit}
  x=opts
end.parse!(ARGV)
#if username argument is not specified, then output help screen and exit
if options[:target].nil?
 puts x
 exit
end

if options[:username].nil?
  options[:username] = "anonymous"
  options[:password] = "anonymous@mozilla.com"
end
target = options[:target]
user = options[:username]
password = options[:password]
if options[:port].nil?
  port = "21"
else
  port = options[:port]
end

#port = "4646"

begin
  ftp_conn = Net::FTP.new # takes options from the init
  ftp_conn.passive = "true"
  ftp_conn.connect(target,port)
  ftp_conn.login(user,password)
  #ftp_conn.open_timeout = 10
rescue Net::FTPReplyError
  puts "SOMETHING WENT WRONG LOL?"
  exit
rescue Errno::ECONNREFUSED
  puts "#{target} - CONNECTION REFUSED"
  exit
rescue SocketError
  puts "#{target} - CANT CONNECT FOR SOME REASON"
  exit
rescue Net::FTPPermError => e
  if e.message.include? "534 Policy requires SSL"
    puts "#{target} - Requres SSL"
  end
  exit
end

if options[:grepable] == 1
  ftp_conn.list.each {|x| puts "#{user}:#{password}@#{target}:     #{x}"}
else
#ftp.nlst.each { |file| puts "#{user}:#{password}@#{target}:/#{file}" } #nlst doesnt work on all FTP servers
puts "#{user}:#{password}@#{target}:" 
ftp_conn.list.each {|x| puts "     #{x}"} #list comes back as array, this will indent the output
end
