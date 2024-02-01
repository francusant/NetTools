#!/bin/sh
# Version 1.4.1 Beta
# A script to test Network Firewall Configuration by checking access to resources according to the Required Firewall Configurations for Datto APs.

# Check if nc is available, and set the tool to use
if command -v nc &>/dev/null; then
  tool="nc"
else
  echo "nc is not available on this system. Please install it."
  exit 1
fi

verbose_output=false

# Check for the -v flag
if [ "$1" = "-v" ]; then
  verbose_output=true
fi

# Function to perform a test with category
perform_test() {
  host="$1"
  port="$2"
  category="$3"
  success=""
  failure=""

  # Use nc to attempt a connection to the host on the specified port
  if $tool -w 3 $host $port </dev/null 2>/dev/null; then
    success="\e[32mSuccess\e[0m: $category: $host - Port $port is accessible"
    if [ "$verbose_output" = true ]; then
      echo -e "$success"
    fi
    successful_tests="$successful_tests\n$success"
  else
    failure="\e[31mFailure\e[0m: $category: $host - Port $port is not accessible"
    if [ "$verbose_output" = true ]; then
      echo -e "$failure"
    fi
    failed_tests="$failed_tests\n$failure"
  fi
}

# Initialize variables for the summary report
successful_tests=""
failed_tests=""

# Test categories
perform_test "cloud_ap.cloudtrax.com" 443 "Category 1 - Cloud Management"

for host in "events-receiver.cloudtrax.com" "ap-files-mirror.cloudtrax.com" "device.cloudtrax.com" "52.13.65.115"; do
  perform_test "$host" 80 "Category 2 - Check-in and Tech Support"
  perform_test "$host" 443 "Category 2 - Check-in and Tech Support"
  perform_test "$host" 2200 "Category 2 - Check-in and Tech Support"
done

perform_test "checkin-fallback.cloudtrax.com" 80 "Category 3 - Access Point Fallback"
perform_test "54.245.251.231" 80 "Category 3 - Access Point Fallback"

for host in "connkeeper.cloudtrax.com" "35.165.84.99" "35.163.125.115" "35.162.249.62"; do
  perform_test "$host" 80 "Category 4 - Datto Connection Keeper"
done

for host in "pool.ntp.org" "0.openwrt.pool.ntp.org" "ntp.cloudtrax.com"; do
  perform_test "$host" 123 "Category 5 - Network Time Protocol"
done

for host in "dev.cloudtrax.com" "files-mirror.cloudtrax.com"; do
  perform_test "$host" 80 "Category 6 - Firmware Updates"
  perform_test "$host" 443 "Category 6 - Firmware Updates"
done

perform_test "vpn.cloudtrax.com" 18991 "Category 7 - Advanced Troubleshooting"

# Print the summary report
echo -e "\nAP Firewall Test v1.4.1 Beta:"
echo -e "======================"
echo -e "Successful Tests:$successful_tests"
echo -e "Failed Tests:$failed_tests"
