#!/bin/bash
# 1000*5min = 83h
END=1000
COUNT=0
LOG=temperature.log
while [ $COUNT -lt 1000 ]; do
    echo "$COUNT"
    date >> temperature.log
    DISK_LABEL=0
    while [ $DISK_LABEL -lt 10 ]; do
        if [ -e /dev/nvme${DISK_LABEL}n1 ]; then
            echo "nvme${DISK_LABEL}n1: " >> $LOG
            smartctl -a /dev/nvme${DISK_LABEL}n1 | grep 'Temperature:' >> $LOG
        fi
        DISK_LABEL=`expr $DISK_LABEL + 1`
    done
    sleep 300
    COUNT=`expr $COUNT + 1`
done
