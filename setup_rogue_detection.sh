#!/bin/bash

echo " Installing necessary tools..."
sudo apt update
sudo apt install -y arp-scan mailutils

echo " Tools installed:"
echo " - arp-scan (LAN scanner)"
echo " - mailutils (for sending alerts)"
