#!/bin/bash
if [ -f "/usr/bin/7zz" ] && ! grep -q "exit 0" "/usr/bin/7zz" 2>/dev/null; then
  mv /usr/bin/7zz /usr/bin/7zz-real
  cp /custom-cont-init.d/7zz-wrapper /usr/bin/7zz
  chmod +x /usr/bin/7zz
fi
