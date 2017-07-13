#!/bin/bash

osname=$(cat /etc/lsb-release | awk 'BEGIN { FS="="; } /^DISTRIB_ID=/{ print $2 }')
osver=$(cat /etc/lsb-release | awk 'BEGIN { FS="="; } /^DISTRIB_RELEASE=/{ print $2 }')

cat realmd.conf.template | sed "s/\${OSNAME}/$osname/" > ./realmd.conf
sed -i "s/\${OSVERSION}/$osver/" ./realmd.conf

defaulthome="/home/%U" 
defaultshell=$SHELL 


sed -i "s/\${REALM}/$1/" ./realmd.conf

if [ -n "$2" ]; then
	defaulthome=$2
fi

if [ -n "$3" ]; then
	defaultshell=$3
fi


sed -i "s?\${DEFAULTHOME}?$defaulthome?" ./realmd.conf
sed -i "s?\${DEFAULTSHELL}?$defaultshell?" ./realmd.conf

mv ./realmd.conf /etc/realmd.conf

cat /etc/realmd.conf

