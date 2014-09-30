#!/bin/bash

W=`date +%W`
Y=`date +%Y`

CPEP=`wc -l /var/www/c-peper.de/logs/access.$Y.week$W.log | awk '{print $1}'`
OFMW=`wc -l /var/www/ofm-wiki/logs/access.$Y-$W.log | awk '{print $1}'`
echo $CPEP
echo $OFMW
CPEP_FEED=`grep "wordpress/feed" /var/www/c-peper.de/logs/access.$Y.week$W.log | grep -v "rss2mail" | wc -l`
echo $CPEP_FEED
