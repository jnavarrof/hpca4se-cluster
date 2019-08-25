#!/bin/bash



[ -z "$1" ] && echo >&2 "A domain name should be provided as a parameter" && exit -1

DOMAIN=$1
DATE=$(date +%s)

set -euo pipefail

# Check domain
virsh list --name | grep -q $DOMAIN &>/dev/nul
[ ! $? -eq 0 ] && echo >&2 "Cannot find domain $DOMAIN. Exist." && exit -1

virsh shutdown $DOMAIN
virsh snapshot-create-as --domain $DOMAIN \
	--name "$DATE" \
	--description "Snapshpot domain $DOMAIN Timestamp $DATE"

sleep 1m
virsh start $DOMAIN

# List snapshots for a domain
virsh snapshot-list --domain $DOMAIN
