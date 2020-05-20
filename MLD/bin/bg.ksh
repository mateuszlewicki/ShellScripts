#!/usr/bin/ksh
app=$1
shift
nohup $@ &
echo PID:$! > /tmp/$app.pid
