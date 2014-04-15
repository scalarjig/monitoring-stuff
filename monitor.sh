vmstat 1 2 |grep -v '^procs'|grep -v 'r' > temp
wget --post-file=temp http://${IP}:${PORT}/postdata