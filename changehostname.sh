#!/bin/bash

display_usage() {
	echo "This command modifies the /etc/hosts file to name the machine"
	echo ""
	echo "Usage: $0 [-d <domainname>] [-h <hostname>]"
	echo ""
	echo "Sets the name of the local computer with the host and domain name provided."
	echo "If the hostname is omitted then the current hostname is uses. If the domain is "
	echo "ommitted then only the hostname is used and no domains are added"
}

if [ $USER != "root" ]; then 
	echo "You need root priveleges to run this script."
	display_usage
	exit 1
fi

HOSTNAME=""
DOMAINNAME=""

# Grab Hostname and domain name from command line arguments
while getopts "d:h:" name; do
	case $name in
		d)
			DOMAINNAME=$OPTARG
			;;
		h)
			HOSTNAME=$OPTARG
			;;
		\?)
			echo "Unknon option -$name"a
			display_usage
			exit 1
			;;
		:)
			echo "-$OPTARG Requires an argument"
			display_usage
			exit 1
			;;
	esac
done

if [ -z "$HOSTNAME" ]; then
	echo "Using default host name $(hostname)"
	HOSTNAME=$(hostname)
fi

if [ -z "$DOMAINNAME" ]; then
	echo "WARNING! No domain provided"
	sed -i -e "s/127\.0\.1\.1\(\s\+\).*$/127.0.1.1\1$HOSTNAME/" /etc/hosts
else
	# Modify the /etc/hosts file to include the FQDN accroding to the domain you are joining
	sed -i -e "s/127\.0\.1\.1\(\s\+\).*$/127.0.1.1\1$HOSTNAME.$DOMAINNAME $HOSTNAME/" /etc/hosts
fi
echo "$HOSTNAME" > /etc/hostname

cat /etc/hosts

echo "YOU NEED TO REBOOT TO HAVE THE CHANGES APPLY"
