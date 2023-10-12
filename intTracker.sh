#!/bin/sh

# Prompt the user for the interface name
printf "Enter the interface name to search for (e.g., eth1): "
read interface

# Use logread to filter log entries for the specified interface
logs=$(logread | grep "$interface" | grep "link is down")

# Extract and count the timestamps
timestamps=$(echo "$logs" | awk '{print $1, $2, $3, $4, $5}')
total_drops=$(echo "$timestamps" | wc -l)

# Function to print a row with evenly spaced columns
print_row() {
    printf "| %-55s | %-45s |\n" "$1" "$2"
}

# Function to print the top and bottom table borders
print_border() {
    printf "+-------------------------------------------------------+-----------------------------------------------+\n"
}

# Get the current date and time
current_time=$(date "+%a %b %d %H:%M:%S %Y %Z")

# Get the system's uptime using 'uptime' and extract the uptime part
uptime_output=$(uptime)
uptime=$(echo "$uptime_output" | awk '{sub(/,$/, "", $3); print $3}')

# Check if the /sys/class/net directory exists before reading link speed
link_speed="N/A Mbps"
if [ -d "/sys/class/net/$interface" ]; then
    link_speed=$(cat "/sys/class/net/$interface/speed" 2>/dev/null || echo "N/A Mbps")
fi

# Print the top table border
print_border

# Print additional information about the interface
print_row "Interface Examined:" "$interface"
print_border

# Print the total uptime and link speed
print_row "Total Uptime:" "$uptime"
print_border
print_row "Link Speed:" "$link_speed"
print_border

# Print information about connection drops
print_row "Total Drops:" "$total_drops"
print_border
print_row "Drop Date(s):" "$current_time"
print_border

i=1
while [ $i -le $total_drops ]; do
    est_timestamp=$(echo "$timestamps" | sed -n "$i p")
    print_row "Drop Date $i:" "$est_timestamp"
    if [ $i -lt $total_drops ]; then
        print_border
    fi
    i=$((i + 1))
done

# Print the bottom table border
print_border
