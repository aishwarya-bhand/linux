#!/bin/bash
process_name=$1
if [[ $# -eq 0 ]];then
	echo 'usage: ./check_process.sh sshd'
	exit 1
fi
pids=$( ps -ef | grep "$process_name" | grep -v grep | awk '{print $2}')
# or pgrep -x  $process-name

if [[ -n '$pids' ]];then
	    echo "Process '$process_name' is running"
	    echo "PIDS: $pids"
else
	    echo "Process '$process_name' is not running"
fi
