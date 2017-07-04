#!/bin/bash

apt install -y krb5-user samba sssd ntp

export DEFAULTREALM=$(awk -f krb5defaultrealm.awk /etc/krb5.conf)

echo $DEFAULTREALM
