#!/usr/bin/env ruby
#decrypt cpassword strings


#parse command line options
require 'optparse'
x=nil
options = {} #hash that hold the options
optparse = OptionParser.new do |opts| #start defining options below
  opts.banner = "Decrypts supplied cpassword values to plaintext
  Usage: #{File.basename($0)} <options>" #the banner to display at the top
  opts.on( '-c', '--cpasswd CPASSWD', 'The cpasswd you want decrypted' ) {|i| options[:cpwd] = i}
  opts.on( '-h', '--help', 'Display this screen' ) {puts opts; exit}
  x=opts
end.parse!(ARGV)
#if username argument is not specified, then output help screen and exit

if not STDIN.tty? and not STDIN.closed?
  options[:cpwd] = STDIN.read
elsif options[:cpwd].nil?
  puts x
  exit 1
end

require 'openssl'
require 'base64'


  def decrypt_cpwd(cpassword)
    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.decrypt
    cipher.key = key = "\x4e\x99\x06\xe8\xfc\xb6\x6c\xc9\xfa\xf4\x93\x10\x62\x0f\xfe\xe8\xf4\x96\xe8\x06\xcc\x05\x79\x90\x20\x9b\x09\xa4\x33\xb6\x6c\x1b" #MS aes key
    padding = "=" * (4 - (cpassword.length % 4))
    cleartext = cipher.update("#{Base64.decode64("#{cpassword}#{padding}")}")
    cleartext << cipher.final
    pass = cleartext.unpack('v*').pack('C*')
    return pass
  end
 puts "#{options[:cpwd]} decrypts to #{decrypt_cpwd(options[:cpwd])}"