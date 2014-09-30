#!/bin/bash
rrdupdate /root/.rrd/load.rrd N:`cat /proc/loadavg | awk '{ print $2 }'`
rrdupdate /root/.rrd/load2.rrd N:`cat /proc/loadavg | awk '{ print $2 }'`
#rrdupdate /root/.rrd/mailq2.rrd N:`/usr/sbin/exim4 -bpc`
rrdupdate /root/.rrd/net.rrd N:`/root/getBytes.sh all.in`:`/root/getBytes.sh all.out`

## mem percentile
MEMT=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`
MEMF=`cat /proc/meminfo | grep MemFre | awk '{print $2}'`
CACH=$(cat /proc/meminfo | grep ^Cached | awk '{print $2}')
MEMU=$(($MEMT-$MEMF-$CACH))
PROZMEM=$(( $MEMU * 1000 / $MEMT ))
/usr/bin/rrdtool update /root/.rrd/mem.rrd N:$PROZMEM

