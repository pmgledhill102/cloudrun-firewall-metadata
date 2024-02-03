#!/bin/bash

# Configure IP Tables
iptables -A OUTPUT -d 169.254.169.254 -j DROP

# Run webserver
python3 server.py