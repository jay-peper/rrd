#!/bin/bash

exit 

rrdtool create net.rrd --step 300 \
  DS:in:GAUGE:1440:0:U \
  DS:out:GAUGE:1440:0:U \
  RRA:AVERAGE:0.5:1:1440

