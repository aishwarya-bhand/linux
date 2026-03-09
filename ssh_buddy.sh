#!/bin/bash
function args(){
        c_ips="compute_ips.txt"
        if [[ -e ${c_ips} ]] && [[ -f ${c_ips} ]];then
                readarray -t ips < ${c_ips}
        else
                printf "Error: ${c_ips} file not found/invalid\n"
                exit 127
        fi
        timeout="5"
        ssh_key="${HOME}/.ssh/id_rsa"
        c_user="acts"
        c_pass="Admin123"
}
function cping(){
        for ip in ${!ips[@]};do
                if timeout "${timeout}" ping -c 2 "${ips[${ip}]}" &> /dev/null;then
                        printf "${ips[${ip}]}\t:\tActive\n"
                else
                        printf "${ips[${ip}]}\t:\tInactive\n"
                fi
        done
}

ssh_key_setup(){
if [[ ! -e "${ssh_key}" ]];then
        ssh-keygen -t rsa -f "${ssh_key}" -N '' &> /dev/null
        printf "SSH key generated successfully.\n"
fi
for ip in ${!ips[@]};do
        if sshpass -p "${c_pass}" ssh-copy-id -o StrictHostKeyChecking=no -f "${c_user}"@"${ips[${ip}]}" &> /dev/null;then
                printf "${ips[${ip}]}: key added successfully.\n"
        else
                printf "${ips[${ip}]}: key copy failed.\n"
        fi
done
}

case ${1} in
        "--ping")
                args "$@"
                cping
                ;;
        "--setup_ssh")
                args "$@"
                ssh_key_setup
                ;;
        "-h"|"--help")
                echo "Demo help"
                exit 0
                ;;
        *)
                printf "Error: Invalid ${1:-UNKNOWN} argument, use -h/--help\n"
                exit 127
                ;;
esac
