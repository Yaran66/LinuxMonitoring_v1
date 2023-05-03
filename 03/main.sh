#/bin/bash

chmod +x getsystinfo.sh
echo "Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black"

#REGEX="^[+-]?[0-9]+([.][0-9]+)?$"
REGEX1_6="^[1-6]$"

if [[ $# -ne 4 ]]; then
    echo "Error! Wrong number of arguments, should be 4 arguments and this should be numbers from 1 to 6 !"
elif ! [[ $1 =~ $REGEX1_6 ]] || ! [[ $2 =~ $REGEX1_6 ]] || ! [[ $3 =~ $REGEX1_6 ]] || ! [[ $4 =~ $REGEX1_6 ]]; then
    echo "Error! Arguments should be numbers from 1 to 6 !"
elif [[ $1 -eq $2 ]] || [[ $3 -eq $4 ]]; then
    echo "Error! Arguments for font and background colours should be different. Try again ! "
else ./getsystinfo.sh $1 $2 $3 $4
fi

