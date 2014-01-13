#!/usr/bin/env ruby

#check if the proper gems are installed
  [ 'rubygems','optparse' ].each {|required_gem|
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
   opts.on( '-t', '--target TARGET', 'The target host to check shares' ) {|i| options[:target] = i}
   opts.on( '-U', '--user \'DOM/user%password\'', 'The SMB Creds to use' ) {|i| options[:creds] = i}
   opts.on( '-h', '--help', 'Display this screen' ) {puts opts; exit}
x=opts
  end.parse!(ARGV)
end
#if target argument is not specified, then output help screen and exit
if options[:target].nil?
 puts x
 exit
end

def parseSMBCreds(creds)
  if creds.split(/%/)[0].match(/\/|\\/) #if creds contain a / or \ (to denote a domain)
    domain = creds.split(/\/|\\/,2)[0]
    user = creds.split(/[\/|\\](.*?)%/)[1]
    password = creds.split(/%/,2)[1]
  else
    domain = ""
    user = creds.split(/%/,2)[0] #split of first occurence of %
    password = creds.split(/%/,2)[1]
  end
  if user.nil?
    puts "You didnt specify a username properly"
    exit
  end
  return domain,user,password
end

def getShareList(opts={}) #domain,user,password,host
  if opts[:domain].nil?
  creds = "#{opts[:user]}%#{opts[:password]}"
else
  creds = "#{opts[:domain]}/#{opts[:user]}%#{opts[:password]}"
end
  host = opts[:host]
  logoncheck = `smbclient -U #{creds} -g -L //#{host} 2>&1`
  
  if logoncheck.include? 'NT_STATUS_LOGON_FAILURE'
    puts "LOGON FAILURE on #{host} - #{creds}"
    exit
  else
    shares = `smbclient -U #{creds} -g -L //#{host} 2>&1 | grep Disk | cut -d '|' -f2`.split("\n")
  return shares #returns an array with share names
end
end


creds = parseSMBCreds(options[:creds])
domain,user,password = creds[0],creds[1],creds[2]

host = options[:target]


#shares = `smbclient -U #{domain}/#{user}%#{password} -g -L //#{host} 2>&1 | grep Disk | cut -d '|' -f2`.split("\n")
shares = getShareList(:domain => domain,:user => user,:password => password,:host => host)
shareList = [] #create array to hold list of accessible shares
shares.each { |i| 
  if system("smbclient -U #{domain}/#{user}%#{password} //#{host}/#{i} -c dir &> /dev/null")
    shareList << i #populate array with list of accessible shares
  end
  }
puts "#{domain}/#{user},#{host},#{shareList.join(',')}"
