#!/bin/bash

#######################################################################
##         MEM Percentage                                            ##
#######################################################################

rrdtool graph /root/.rrd/mem_lin_hour.png -w360 \
--start -3600 \
DEF:mem1=/root/.rrd/mem.rrd:load:LAST \
DEF:mem2=/root/.rrd/mem.rrd:load:AVERAGE:step=300 \
DEF:mem3=/root/.rrd/mem_fast2.rrd:avg:AVERAGE:step=60 \
DEF:mem4=/root/.rrd/mem_fast2.rrd:avg:AVERAGE:step=300 \
CDEF:mem1c=mem1,10,/ \
CDEF:mem2c=mem2,10,/ \
CDEF:mem3c=mem3,1,/ \
CDEF:mem4c=mem4,1,/ \
COMMENT:"last hour" \
AREA:mem1c#FF0000:"last" \
LINE1:mem2c#0000FF:"5min avg" \
LINE1:mem3c#FFFF00:"fast last" \
LINE1:mem4c#00FFFF:"fast 5min avg" \
-v "MEM Percentage" -W "Hermes"

rrdtool graph /root/.rrd/mem_lin_3hrs.png \
--start -10800 \
DEF:mem1=/root/.rrd/mem.rrd:load:LAST \
DEF:mem2=/root/.rrd/mem.rrd:load:AVERAGE:step=900 \
CDEF:mem1c=mem1,10,/ \
CDEF:mem2c=mem2,10,/ \
COMMENT:"last 3 hours" \
LINE1:mem1c#FF0000:"last" \
LINE1:mem2c#0000FF:"15min avg" \
-v "mem percentage" -W "Hermes"

rrdtool graph /root/.rrd/mem_lin_day.png \
--start -86400 \
DEF:mem1=/root/.rrd/mem.rrd:load:LAST \
DEF:mem2=/root/.rrd/mem.rrd:load:AVERAGE:step=900 \
DEF:mem3=/root/.rrd/mem.rrd:load:AVERAGE:step=3600 \
CDEF:mem1c=mem1,10,/ \
CDEF:mem2c=mem2,10,/ \
CDEF:mem3c=mem3,10,/ \
COMMENT:"last day" \
LINE1:mem1c#FF8080:"last value" \
LINE1:mem2c#00FF00:"15min avg" \
LINE1:mem3c#0000FF:"1h avg" \
-v "MEM percentage" -W "Hermes"

rrdtool graph /root/.rrd/mem_lin_week.png \
--start -604800 \
DEF:mem1=/root/.rrd/mem.rrd:load:LAST \
DEF:mem2=/root/.rrd/mem.rrd:load:AVERAGE:step=3600 \
CDEF:mem1c=mem1,10,/ \
CDEF:mem2c=mem2,10,/ \
COMMENT:"last week" \
LINE1:mem1c#FF8080:"last" \
LINE1:mem2c#0000FF:"1h avg" \
-v "MEM Percentage" -W "Hermes"

#################
## logarithmic ##
#################

rrdtool graph /root/.rrd/mem_log_hour.png -Y \
--start -3600 \
-o --units=si \
DEF:mem1=/root/.rrd/mem.rrd:load:LAST \
DEF:mem2=/root/.rrd/mem.rrd:load:AVERAGE:step=300 \
DEF:mem3=/root/.rrd/mem_fast2.rrd:avg:AVERAGE:step=60 \
DEF:mem4=/root/.rrd/mem_fast2.rrd:avg:AVERAGE:step=300 \
CDEF:mem1c=mem1,10,/ \
CDEF:mem2c=mem2,10,/ \
CDEF:mem3c=mem3,1,/ \
CDEF:mem4c=mem4,1,/ \
COMMENT:"last hour" \
LINE1:mem1c#FF0000:"last" \
LINE1:mem2c#0000FF:"5min avg" \
LINE1:mem3c#FFFF00:"fast last" \
LINE1:mem4c#00FFFF:"fast 5min avg" \
-v "MEM Percentage" -W "Hermes"

rrdtool graph /root/.rrd/mem_log_3hrs.png \
--start -10800 \
-o --units=si \
DEF:load=/root/.rrd/mem.rrd:load:LAST \
DEF:load2=/root/.rrd/mem.rrd:load:AVERAGE:step=300 \
DEF:load3=/root/.rrd/mem.rrd:load:AVERAGE:step=900 \
CDEF:load1c=load,10,/ \
CDEF:load2c=load2,10,/ \
CDEF:load3c=load3,10,/ \
COMMENT:"last 3 hours" \
LINE1:load1c#FF0000:"last" \
LINE1:load2c#00FF00:"5min" \
LINE1:load3c#0000FF:"15min" \
-v "Percentage" -W "Hermes"

rrdtool graph /root/.rrd/mem_log_day.png \
--start -86400 \
-o --units=si \
DEF:load=/root/.rrd/mem.rrd:load:LAST \
DEF:load2=/root/.rrd/mem.rrd:load:AVERAGE:step=900 \
DEF:load3=/root/.rrd/mem.rrd:load:AVERAGE:step=3600 \
COMMENT:"last day" \
LINE1:load#FF8080:"last" \
LINE1:load2#0000FF:"15min avg" \
LINE1:load3#00FF00:"1h avg" \
-v "Percentage" -W "Hermes"

rrdtool graph /root/.rrd/mem_log_week.png \
--start -604800 \
-o --units=si \
DEF:load=/root/.rrd/mem.rrd:load:LAST \
DEF:load3=/root/.rrd/mem.rrd:load:AVERAGE:step=3600 \
COMMENT:"last week" \
LINE1:load#FF8080:"last" \
LINE1:load3#0000FF:"1h avg" \
-v "Percentage" -W "Hermes"

# cp -f /root/.rrd/*.png /var/www/peper-home.net/htdocs/rrd/
