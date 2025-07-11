#!/bin/bash

# === CONFIG ===
AUTHORIZED_FILE="authorized_devices.txt"
ROGUE_FILE="rogue_devices.txt"
SUBNET="192.168.1.0/24"       # Replace with your LAN subnet
EMAIL="security@example.com"  # Email for alerts
TMP_FILE="scan_result.txt"
# ==============

echo " Scanning local network on $SUBNET..."
sudo arp-scan --interface=$(ip route | grep default | awk '{print $5}' | head -n1) "$SUBNET" > "$TMP_FILE"

# Extract MAC and Hostname/IP
grep -E "([0-9A-F]{2}:){5}[0-9A-F]{2}" "$TMP_FILE" | awk '{print toupper($2) " " $1}' | sort > current_devices.txt

# Compare with authorized list
if [[ ! -f "$AUTHORIZED_FILE" ]]; then
  echo " Authorized devices list ($AUTHORIZED_FILE) not found."
  exit 1
fi

sort "$AUTHORIZED_FILE" > sorted_authorized.txt

# Find rogue devices
comm -23 current_devices.txt sorted_authorized.txt > "$ROGUE_FILE"

if [[ -s "$ROGUE_FILE" ]]; then
    echo " Rogue devices detected! Logging..."

    echo "Subject:  Rogue Devices Detected on LAN" > email_body.txt
    echo "" >> email_body.txt
    echo "The following unknown devices were found on the network ($SUBNET):" >> email_body.txt
    cat "$ROGUE_FILE" >> email_body.txt
    echo "" >> email_body.txt
    echo "Please investigate these devices immediately." >> email_body.txt

    # Send alert email (optional)
    mail -s " Rogue Devices on LAN" "$EMAIL" < email_body.txt

    echo " Rogue devices logged in $ROGUE_FILE and alert sent to $EMAIL"
else
    echo " No rogue devices found."
fi

# Clean up
rm -f email_body.txt sorted_authorized.txt current_devices.txt "$TMP_FILE"
