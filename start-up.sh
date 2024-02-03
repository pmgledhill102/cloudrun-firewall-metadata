#!/bin/bash

# Configure IP Tables
# (Just filter ports 80 & 443 otherwise DNS on port 53 will stop working)
iptables -A OUTPUT -d 169.254.169.254 -p tcp --dport 80 -j DROP
iptables -A OUTPUT -d 169.254.169.254 -p tcp --dport 443 -j DROP

# Run webserver
python3 server.py