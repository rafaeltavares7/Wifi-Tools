#!/bin/bash

cap="$1"

tshark -r "$cap" -Y "arp" -T fields -e arp.src.proto_ipv4 | sort | uniq > ip.txt

for ip in $(cat ip.txt); do
  tshark -r "$cap" -Y "(http || dns) && ip.src == $ip" -T fields -e frame.time -e ip.src -e ip.dst -e _ws.col.Protocol -e dns.qry.name -e http.host -e http.request.uri -e http.user_agent -e http.file_data -e http.cookie | sort -n | uniq > "$ip.txt"
done

rm ip.txt
