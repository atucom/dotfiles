#!/usr/bin/env python
"""Returns HTML title from supplied URL"""

import argparse
import sys
import urllib2
from BeautifulSoup import BeautifulSoup

def main():
    """Main Program Execution"""
    parser = argparse.ArgumentParser(description='Grabs HTML Title from supplied URL',
                                    formatter_class=argparse.RawDescriptionHelpFormatter,
                                    epilog="Example: \n\t%s http://www.google.com"%(sys.argv[0])  )
    
    parser.add_argument('URL', 
    					help='Target URL to retrieve Title tag from')
    args = parser.parse_args() #reference args with args.argument_name
    urltarget = args.URL


    try:
        urllib2.urlopen(urltarget)
    except urllib2.HTTPError, e:
        print urltarget, '--- HTTPERROR: [%s]' % (e.message)
        quit()
    except ValueError, e:
        print urltarget, '--- VALUEERROR: [%s]' % (e.message)
        quit()
    except urllib2.URLError, e:
        print urltarget, '--- URLERROR: [%s]' % (e.reason)
        quit()


    soup = BeautifulSoup(urllib2.urlopen(urltarget))

    if soup.title:
      print urltarget, "--- ", soup.title.string
    else:
      print urltarget, '--- No Title Detected'

if __name__ == '__main__':
    sys.exit(main())