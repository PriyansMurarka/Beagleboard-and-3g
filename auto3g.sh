#!/bin/bash

# Script Name: auto3g.sh
# Creator    : Priyans
# Use        : This script automatically connects a beagle board to a 3G network when a dongle is connected.
# Example    : sh auto3g.sh

################################################

## Main Script

## lsusb_op contains the line output of the lsusb command with ONDA Communications
lsusb_op=`lsusb | grep ONDA`

#echo $lsusb_op

## Extract the device id.
dev_id=$(echo $lsusb_op | awk '{print $6}')

#echo $dev_id

## This ensures that the dongle is recognized as a serial connection.
usb_modeswitch -c /etc/usb_modeswitch.d/$dev_id

## Dial the subscriber
pppd logfile pppd.txt call provider &

## Sleep time is the waiting time for the dongle to connect
sleep 5m

## Extract the ip address of ppp0 . Store it as myip
myip=`ip addr show ppp0 | sed -n '3p' | awk '{ print $2 }' | cut -f 1 -d "/"`
#echo $myip
