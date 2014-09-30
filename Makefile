CC=gcc
stat: stat.c
	gcc stat.c /lib64/libprocps.so.1 -o stat
