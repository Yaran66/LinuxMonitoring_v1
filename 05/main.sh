#/bin/bash

startScrypt=$(($(date +%s%N)/1000000))
chmod +x getsystinfo.sh

#REGEX="^[0-9]+([.][0-9]+)?+[KMGT]$"
REGEX2="/$"

startScrypt=$(($(date +%s%N)/1000000))

error1 () {
if [[ $# -ne 1 ]]; then echo "Error! only 1 argument is allowed! Try again !" >&2
exit 1;
elif [[ ! -d $1 ]]; then echo "Error! Argument should be directory! Try again !" >&2
exit 1;
elif [[ ! $1 =~ $REGEX2 ]]; then echo "Error! Argument must end with '/'" >&2
exit 1;
else ./getsystinfo.sh $1
fi
}

error1 $@

endScrypt=$(( $(date +%s%N)/1000000 - $startScrypt ))
echo "Script execution time (in seconds) =" $(echo $endScrypt | awk '{printf "%.1f", $1/1000}')
