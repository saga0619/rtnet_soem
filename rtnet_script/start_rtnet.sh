#!/bin/bash

# To start rtnet, type start_rtnet.sh start.
# To stop rtnet, type start_rtnet.sh stop.

# -------------------------------
# ------- Configuration  --------
# Pci address of NIC (ex: 0000:03:00.0)
#   Pci address can be checked with lspci
devices="0000:03:00.0 0000:03:00.1 0000:04:00.0 0000:04:00.1"

# default loaded driver on the NIC.
#   List of drivers that can be used on the NIC, can be checked with 'lspci -v' command on terminal. (ex: kernel modules : igb, rt_igb)
driver="igb"

# RT driver to use with the NIC (usually comes with 'rt_' letters are in front of driver name)
rtdriver="rt_igb"
# ------ Configuration End ------
# -------------------------------


case "$1" in
    start)
        modprobe rtpacket
        dev_num=0
        for dev in $devices; do
            if [ -d /sys/bus/pci/devices/$dev/driver ]; then
            echo $dev unbind $driver
	    echo -n $dev > /sys/bus/pci/drivers/$driver/unbind
            fi
	    echo $dev bind $rtdriver
            echo -n $dev > /sys/bus/pci/drivers/$rtdriver/bind
	    echo rtifconfig rteth$dev_num up promisc
            rtifconfig rteth$dev_num up promisc
            dev_num=$(($dev_num + 1))
        done
	;;
    stop)
        rmmod rtpacket
        dev_num=0
        for dev in $devices; do
            rtifconfig rteth$dev_num down
            echo 1 > /sys/bus/pci/devices/$dev/remove
            echo removing $dev to $rtdriver
            dev_num=$(($dev_num + 1))
        done
	echo rescan pci devices
        echo 1 > /sys/bus/pci/rescan
        
	;;
    *)

        cat << EOF
Usage:
    start stop
EOF
	;;
esac









