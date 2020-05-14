#!/bin/bash

if [ ! -f pks-autoscaler.config ]; then
	cp pks-autoscaler.config.template pks-autoscaler.config
fi

echo "PKS-AUTOSCASLER PRE-REQ INSTALLER AND CHECKER"

if command -v om >/dev/null 2>&1 ; then
  	echo "OM CLI installed. Skipping...."
else
  	echo "OM CLI not installed."
fi

if command -v pks >/dev/null 2>&1 ; then
  	echo "PKS CLI installed. Skipping...."
else
  	echo "PKS CLI not found. Please download the latest binary locally from PIVNET"
fi

if command -v bc >/dev/null 2>&1 ; then
  	echo "bc installed. Skipping...."
else
  	echo "bc not found. Download from brew or yum/dnf or apt"
fi

if command -v jq >/dev/null 2>&1 ; then
  	echo "jq installed. Skipping...."
else
  	echo "jq not found. Download from brew or yum/dnf or apt"
fi