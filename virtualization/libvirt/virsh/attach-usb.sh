#!/bin/bash
set -euo pipefail

VM_NAME="fedora-test"
USB_CONFIG="/tmp/usb.xml"

# find ids
lsusb

# overwrite ids
VENDOR_ID="0x058f"
PRODUCT_ID="0x6387"

# unmount usb from host
sudo umount /run/media/kivanc57/USB

# write config
cat > "${USB_CONFIG}" <<EOF
<hostdev mode='subsystem' type='usb'>
  <source>
    <vendor id='${VENDOR_ID}'/>
    <product id='${PRODUCT_ID}'/>
  </source>
</hostdev>
EOF

# attach usb as config
sudo virsh attach-device "${VM_NAME}" "${USB_CONFIG}" --live

