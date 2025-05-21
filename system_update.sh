#!/bin/bash

# Define log file location
LOG_FILE="/var/log/system_update.log"

# Function to log messages
log_message() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Detect package manager
if command -v apt > /dev/null 2>&1; then
  PACKAGE_MANAGER="apt"
elif command -v yum > /dev/null 2>&1; then
  PACKAGE_MANAGER="yum"
else
  log_message "Error: No supported package manager found (apt or yum)."
  exit 1
fi

# Log start of the update process
log_message "Starting system update process using $PACKAGE_MANAGER."

# Update the package index and upgrade the system
if [ "$PACKAGE_MANAGER" = "apt" ]; then
  log_message "Updating package index..."
  apt update -y >> "$LOG_FILE" 2>&1

  log_message "Upgrading packages..."
  apt upgrade -y >> "$LOG_FILE" 2>&1
elif [ "$PACKAGE_MANAGER" = "yum" ]; then
  log_message "Updating package index..."
  yum check-update >> "$LOG_FILE" 2>&1

  log_message "Upgrading packages..."
  yum update -y >> "$LOG_FILE" 2>&1
fi

# Log completion
if [ $? -eq 0 ]; then
  log_message "System update completed successfully."
else
  log_message "System update encountered errors. Check the log file for details."
fi
