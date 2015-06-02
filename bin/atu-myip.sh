#get the external IP 

curl httpbin.org/ip 2> /dev/null| grep origin | awk '{print $2}' | tr -d '"'