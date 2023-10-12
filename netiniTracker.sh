#!/bin/sh

# Prompt the user for the interface name
printf "Enter the interface name to search for (e.g., eth1): "
read interface

# Use grep to filter log entries for the specified interface
logs=$(grep "$interface" /var/log/messages | grep "link is down")

# Extract and count the timestamps
timestamps=$(echo "$logs" | awk '{print $1, $2, $3, $4, $5}')
total_drops=$(echo "$timestamps" | wc -l)

# Function to print a row with evenly spaced columns
print_row() {
    printf "| %-35s | %-30s |\n" "$1" "$2"
}

# Function to print the top and bottom table borders
print_border() {
    printf "+-------------------------------------+------------------------------+\n"
}

# Get the current date and time
current_time=$(date "+%a %b %d %H:%M:%S %Y %Z")

# Print the top table border
print_border

# Print additional information about the interface
print_row "Interface Examined:" "$interface"
print_border

# Print the total uptime and link speed
uptime=$(uptime -p)
link_speed=$(cat /sys/class/net/"$interface"/speed)
print_row "Total Uptime:" "$uptime"
print_border
print_row "Link Speed:" "${link_speed} Mbps"
print_border

# Print information about connection drops
print_row "Total Drops:" "$total_drops"
print_border
print_row "Drop Date(s):" ""
print_border

i=1
while [ $i -le $total_drops ]; do
    est_timestamp=$(date --date="$(echo "$timestamps" | sed -n "$i p") UTC" "+%a %b %d %H:%M:%S %Y %Z" -d "5 hours ago")
    print_row "Drop Date $i:" "$est_timestamp"
    if [ $i -lt $total_drops ]; then
        print_border
    fi
    i=$((i + 1))
done

# Print the bottom table border
print_border
