#!/bin/bash

THRESHOLD=80

LOG_FILE="/var/log/disk_usage_alerts.log"

disk_usage=$(df -h | awk 'NR>1 {print $5 " " $1}')

echo "$disk_usage" | while read -r usage filesystem; do
	usage=${usage%\%}

    if [ "$usage" -ge "$THRESHOLD" ]; then
        alert_message="🚨 ALERT: Disk usage on $filesystem is at ${usage}% (Threshold: $THRESHOLD%)"

        echo "$(date): $alert_message" >> "$LOG_FILE"

        echo "$alert_message"
    fi
done
