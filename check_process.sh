#!/bin/bash
process_name=$1
log_file=./process_monitor.log
restart_process="systemctl start $process_name"


#======================
# 1.checking input
# =====================


if [[ $# -eq 0 ]];then
	echo 'usage: ./check_process.sh sshd'
	exit 1
fi

#==============================
#2. check process is running 
#===============================

pids=$( ps -ef | grep "$process_name" | grep -v grep | awk '{print $2}')
# or pgrep -x  $process-name

if [[ -n '$pids' ]];then
	    echo "Process '$process_name' is running"
	    echo "PIDS: $pids"
	    echo "$date: $process_name is running pid: $pids" >> $log_file

#================================
#3.cpu and memory usage
#================================

	   echo "cpu and memory usage:"
	   #ps -p $pids pid,%cpu,%mem,cmd
	     ps | grep sshd | grep -v grep



else
	    echo "Process '$process_name' is not running"
	    echo "$date: $process_name is not running pid: $pids" >> $log_file
#==============================
#4.auto restarting process
#==============================


$restart_process
	if [ $? -eq 0 ]; then
    		echo "Restart successful"
    		echo "$(date): Restarted $process_name successfully" >> $log_file
	else
    		echo "Restart failed"
    		echo "$(date): Failed to restart $process_name" >> $log_file
	fi

fi





