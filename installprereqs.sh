#!/bin/bash

apt install -y krb5-user samba sssd ntp realmd adcli libwbclient-sssd sssd-tools samba-common packagekit samba-common-bin samba-libs ntpstat

export DEFAULTREALM=$(awk -f krb5defaultrealm.awk /etc/krb5.conf)

echo $DEFAULTREALM
