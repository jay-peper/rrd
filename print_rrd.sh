#!/bin/bash

/root/.rrd/print_fast_mem.sh
/root/.rrd/print_mem.sh
/root/.rrd/print_load.sh
/root/.rrd/print_net.sh

cp -f /root/.rrd/*.png /var/www/peper-home.net/htdocs/rrd/
