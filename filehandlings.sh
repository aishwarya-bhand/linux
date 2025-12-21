
#!/bin/bash


#check if file argument is provided by user
filename=$1
word=$2
if [[ $# -eq 0 ]];then
        echo "usage: ./script.sh <filename>"
	exit 0
fi



#checking sixe of file
if [[ -f $filename ]];then
        echo "File size: $(ls -lh $filename | awk '{print $5}')"

        # two more ways to print size of file


        # echo "$(wc -c $filename)"
        # or echo "$(stat -c %s $filename)"


#Count the number of lines containing the word "xyz"

	count=$(grep -o $word $filename | wc -l)
	echo "$word word count: $count"
	if [[  $count -gt 0 ]];then
		echo "word found! Check immediately."
	else
		echo "word not found"
	fi
	

else
        echo "file does not exist"
        echo "$(touch /c/Users/91801/Desktop/work/linux_projects/$filename)$filename:file created succesfully"
fi




