#!/usr/bin/env bash
set -env

# Configure host to use timezone
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html
echo "### Setting timezone to $TIMEZONE ###"
sudo tee /etc/sysconfig/clock << EOF > /dev/null
ZONE="$TIMEZONE"
UTC=true
EOF

sudo ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

# Use AWS NTP Sync service
echo "server 169.254.169.123 prefer iburst" | sudo tee -a /etc/ntp.conf

# Enable NTP
sudo chkconfig ntpd on