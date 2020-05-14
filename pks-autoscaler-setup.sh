#!/bin/bash

source pks-autoscaler.config

echo "PKS-AUTOSCASLER PRE-REQ INSTALLER AND CHECKER"
echo " "
echo " "
echo "Make sure you are running this script on the OPSMANAGER..."

if command -v om >/dev/null 2>&1 ; then
  	echo "OM CLI installed. Skipping...."
else
  	echo "ERROR!!!!"
  	echo "OM CLI not found. Please download the latest binary locally from PIVNET, set the permissions to execute, and move it to /usr/local/bin"
	echo "Once installed, please re-run this script."
fi

if command -v pks >/dev/null 2>&1 ; then
  	echo "PKS CLI installed. Skipping...."
else
	echo "ERROR!!!!"
  	echo "PKS CLI not found. Please download the latest binary locally from PIVNET, set the permissions to execute, and move it to /usr/local/bin"
	echo "Once installed, please re-run this script."
	exit 1
fi

sudo apt-get -y update
sudo apt-get -y install bc jq python-pip
sudo -H pip install yq



read -p "Provide Opsman username, that will be used to execute this script: " name
read -p "Enter password for ${name}: " password
echo
echo "Updating scripts with provided credentials..."
sed -i "s/om_user/${name}/" pks-autoscaler.sh
sed -i "s/om_user/${name}/" pks-autoscaler-scheduler.sh
sed -i "s/om_password/${password}/" pks-autoscaler.sh
sed -i "s/om_password/${password}/" pks-autoscaler-scheduler.sh

if [[ ${RUN_SCHEDULED} -eq 1 ]]
then
	echo "Setting up cron job..."
	sudo systemctl start cron
	if [[ $(sudo crontab -l 2>/dev/null | egrep -v "^(#|$)" | grep -q 'pks-autoscaler-scheduler.sh'; echo $?) == 1 ]]
	then
		sudo crontab -l 2>/dev/null; echo "*/${SCRIPT_FREQ_MIN} * * * * /home/ubuntu/pks-autoscaler/pks-autoscaler-scheduler.sh" | sudo crontab -
	fi
fi