These are various configuration and customization files/scripts for my 
environments.


----------

Installation
------------

**[install.sh](install.sh)** is meant to handle the set up process.
 
 - It symlinks the conf files to their proper locations   
 - it backs up previous configs to *.bak

The bin/ scripts have "atu-" prepended to them so it is easy to find them by hitting tab after typing "atu-"

----------

bin/
----

**[atu-cpassword-decrypt.rb](bin/atu-cpassword-decrypt.rb)**
-Decrypts cpassword value grabbed from SYSVOL. Use    atu-cpassword-search.sh to easily grab all instances of cpassword

**[atu-cpassword-search.sh](bin/atu-cpassword-search.sh)**
  -Mounts the specified domain controller SYSVOL share and automatically greps through for all instances of cpassword
  
**[atu-dclist.sh](bin/atu-dclist.sh)**
  -Given the name of the domain (example.com), queries DNS for both Primary DC and normal DCs
  
**[atu-echo_color.sh](bin/atu-echo_color.sh)**
  -Helper script for supplying colored output

**[atu-expand_range.sh](bin/atu-expand_range.sh)**
  -expands nmap format ranges to list of individual IPs

**[atu-find-by-size.sh](bin/atu-find-by-size.sh)**
  -Find files in current directory that are the specified size

**[atu-ftpDirList.rb](bin/atu-ftpDirList.rb)**
  -list files in FTP directory, also greppable format for easy parsing

**[atu-gempath.sh](bin/atu-gempath.sh)**
  -Troubleshooting script to list out the gem paths that are recognized by Ruby, Gem, Gem Install Dir, $GEM_PATH, $GEM_HOME

**[atu-geolocateapi.rb](bin/atu-geolocateapi.rb)**
  -Given a list of wifi MACs, provides GPS coordinates for location based on google's geolocate API

**[atu-grabtitle.py](bin/atu-grabtitle.py)**
  -Grabs the HTML title for a webpage

**[atu-hash.ntlm.sh](bin/atu-hash.ntlm.sh)**
  -Generates the ntlm hash of supplied input

**[atu-hostmap.rb](bin/atu-hostmap.rb)**
  -Ghetto man's hostmap. Pulls SSL Subject Name and reverse resolves an IP to get a list of domains.

**[atu-hostwrangle.rb](bin/atu-hostwrangle.rb)**
  -Converts nmap xml to greppable list. Each host/port on its own line. (I hate gnmap format)

**[atu-ipinfo.sh](bin/atu-ipinfo.sh)**
  -Outputs Hostname, IP Addr, Gateway, Network, DNS for local machine

**[atu-luhn.rb](bin/atu-luhn.rb)**
  -Performs credit card LUHN check on supplied input

**[atu-mountshare.sh](bin/atu-mountshare.sh)**
  -Mounts a remote share so you can browse it like it's local. Accepts smbclient formatted creds.

**[atu-myip.sh](bin/atu-myip.sh)**
  -Returns your IP addr as seen from the Internet

**[atu-nessuswrangle.rb](bin/atu-nessuswrangle.rb)**
  -same as hostwrangle but with .nessus files

**[atu-nfs-count.sh](bin/atu-nfs-count.sh)**
  -Automounts open nfs shares and checks for number of readable files

**[atu-shareEnum.rb](bin/atu-shareEnum.rb)**
  -Enumerates smb shares available to particular logins. Great for finding who has local admin where.

**[atu-smb_version.sh](bin/atu-smb_version.sh)**
  -My ghetto version of metasploit's smb_version

----------
