#!/bin/sh

# Variables
DOMAIN=$DOMAIN
SOURCE_DNS=$SOURCE_DNS
SLEEP_INTERVAL=${SLEEP_INTERVAL:-60}
PREVIOUS_RESULT=""

# Function to sort IP addresses and join them with commas
sort_ips() {
    echo "$1" | tr ' ' '\n' | sort | tr '\n' ' ' | sed 's/ $//'
}

# Function to update Route53
update_route53() {
    python ./route53-apex-flattener --domain $DOMAIN --source-dns $SOURCE_DNS
}

# Infinite loop to check DNS and update Route53 if necessary
while true; do
    # Query the DNS for IP addresses
    CURRENT_RESULT=$(dig +short $SOURCE_DNS | tr '\n' ' ' | sed 's/ $//')
    SORTED_CURRENT_RESULT=$(sort_ips "$CURRENT_RESULT")

    # Compare with the previous result
    if [ "$SORTED_CURRENT_RESULT" != "$PREVIOUS_RESULT" ]; then
        echo "IP addresses have changed. Updating Route53..."
        update_route53
        PREVIOUS_RESULT=$SORTED_CURRENT_RESULT
    else
        echo "IP addresses have not changed. No update necessary."
    fi

    # Sleep for the configured interval
    sleep $SLEEP_INTERVAL
done

