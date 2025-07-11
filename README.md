# 🕵️ MAC Detection – Rogue Device Identification

This script scans the local network using `arp-scan`, identifies all connected MAC addresses, and compares them with a predefined whitelist to detect unauthorized (rogue) devices.

---

## 🎯 Purpose

- Detect unauthorized devices such as rogue laptops, access points, or personal phones connecting to internal networks.
- Provide visibility and alerts on any device that is not part of the approved infrastructure.

---

## 🔐 Use Case

Used by network security engineers to monitor LAN segments and flag any unknown MAC addresses, helping prevent insider threats and shadow IT.

---

## 📂 Files Used

### `authorized_devices.txt`

```text
AA:BB:CC:DD:EE:01  Laptop-1
AA:BB:CC:DD:EE:02  Server-1
