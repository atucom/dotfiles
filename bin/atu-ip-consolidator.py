#!/usr/bin/env python3
#takes in a file of one-per-line IPs and consolidates them into ranges
#@atucom

import ipaddress
import argparse
import sys

result = []
def consolidate(ipobj):
  result.append(ipobj)
  for ipstr in iparry:
    ipobj2 = ipaddress.ip_address(ipstr)
    if ipobj + 1 == ipobj2:
      result.append(ipobj2)
      iparry.remove(ipstr)
      consolidate(ipobj2)

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument("FILE" ,help='The input file of one-per-line IPs to consolidate')
  args = parser.parse_args()
  if args.FILE:
    with open(args.FILE, 'r') as f:
      iparry = f.read().splitlines()
    for ipstr in iparry:
      consolidate(ipaddress.ip_address(ipstr))
      if ipaddress.ip_address(ipstr) == result[-1]:
        print(result[-1])
      else:
        print("%s - %s" % (ipaddress.ip_address(ipstr), result[-1]))
  else:
    exit(1)