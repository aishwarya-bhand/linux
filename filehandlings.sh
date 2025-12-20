
#!/bin/bash


#check if file argument is provided by user
filename=$1
if [[ $# -eq 0 ]];then
        echo "usage: ./script.sh <filename>"
	exit 0
fi
if [[ -f $filename ]];then
        echo "File size: $(ls -lh $filename | awk '{print $5}')"

        # two more ways to print size of file


        # echo "$(wc -c $filename)"
        # or echo "$(stat -c %s $filename)"
else
        echo "file does not exist"
        echo "$(touch /c/Users/91801/Desktop/work/linux_projects/$filename)$filename:file created succesfully"
fi




