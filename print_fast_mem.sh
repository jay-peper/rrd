#!/bin/bash

rrdtool graph /root/.rrd/mem_fast_h.png -A -w 360 -h 200 -u 100 -l 0 -Y \
--start -3600 \
DEF:min=/root/.rrd/mem_fast2.rrd:min:MIN:step=60 \
DEF:avg=/root/.rrd/mem_fast2.rrd:avg:LAST \
DEF:max=/root/.rrd/mem_fast2.rrd:max:MAX:step=60 \
COMMENT:"last hour" \
LINE0.8:max#0000FF:"maximum" \
LINE1.3:avg#FF0000:"average" \
LINE0.8:min#008000:"minimum" \
-v "fast mem percentage" -W "Hermes"
#DEF:mem1=/root/.rrd/mem.rrd:load:LAST \
#CDEF:mem1c=mem1,10,/ \
#LINE0.2:mem1c#000000:"meminfo" \

rrdtool graph /root/.rrd/mem_fast_m.png -A -w 300 -h 200 \
--start -300 -Y -L 4 \
DEF:min=/root/.rrd/mem_fast.rrd:min:LAST \
DEF:avg=/root/.rrd/mem_fast.rrd:avg:LAST \
DEF:max=/root/.rrd/mem_fast.rrd:max:LAST \
DEF:minmin=/root/.rrd/mem_fast2.rrd:min:MIN:step=60 \
DEF:maxmax=/root/.rrd/mem_fast2.rrd:max:MAX:step=60 \
COMMENT:"last 5 minutes" \
LINE1:min#00FF00:"minimum" \
LINE1:max#0000FF:"maximum" \
LINE1:avg#FF0000:"average" \
LINE1:minmin#008000:"1min minimum" \
LINE1:maxmax#000080:"1min maximum" \
-v "fast mem percentage" -W "Hermes"

#DEF:mem1=/root/.rrd/mem.rrd:load:LAST \
#VDEF:avgavg=avg,AVERAGE \
#CDEF:mem1c=mem1,10,/ \
#LINE0.5:mem1c#000000:"meminfo" \
#LINE0.5:avgavg#FF0000:"60s average" \

cp /root/.rrd/mem_fast* /var/www/peper-home.net/htdocs/rrd
