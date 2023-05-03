#/bin/bash

# function colourNumber need to be written

function colourNumber {

case "$1" in
1) echo "7" ;; #white
2) echo "1" ;; #red
3) echo "2" ;; #green
4) echo "4" ;; #blue
5) echo "5" ;; #purple
6) echo "0" ;; #black
esac

}

COLOUR_BACK=$( colourNumber $1 )
COLOUR=$( colourNumber $2 )
COLOUR_BACK2=$( colourNumber $3 )
COLOUR2=$( colourNumber $4 )

TEXT_NAME="\033[3${COLOUR}m"
BACKGR_NAME="\033[4${COLOUR_BACK}m"
TEXT="\033[3${COLOUR2}m"
BACKGR="\033[4${COLOUR_BACK2}m"
NC='\033[0m'

function printColour {

echo -e "${TEXT_NAME}${BACKGR_NAME}$1 ${NC}=${TEXT}${BACKGR}$2 ${NC}"

}

printColour "HOSTNAME" "$(hostname)"
printColour "TIMEZONE" "$(timedatectl | grep "Time zone" | awk '{print $3}') UTC $(date +%:::z)"
printColour "USER" "$(whoami)"
printColour "OS" "$(hostnamectl | grep "Operating System" | awk '{printf ("%s%s%s", $3, $4, $5)}')"
printColour "DATE" "$(date +"%d %B %Y %T")"
printColour "UPTIME" "$(uptime -p | cut -f2- -d' ')"
printColour "UPTIME_SEC" "$(cat /proc/uptime | awk '{printf ("%i", $1)}')"
printColour "IP" "$(hostname -I | awk '{print $1}')"
maskshort=$(ip -o -f inet addr show | awk '/scope global/ {print $4}' | cut -d'/' -f2 )
mask=$((0xffffffff << (32 - maskshort))); shift
ui32=$mask; shift
  for n in 1 2 3 4; do
      ipaddr=$((ui32 & 0xff))${ipaddr:+.}$ipaddr
      ui32=$((ui32 >> 8))
  done
printColour "MASK" "$ipaddr"
printColour "GATEWAY" "$(/sbin/ip route | awk '/default/ { print $3 }')"
printColour "RAM_TOTAL" "$(grep MemTotal /proc/meminfo | awk '{printf("%.3f GB\n", ($2/1024)/1024);}')"
printColour "RAM_USED" "$(free | grep Mem: | awk '{printf("%.3f GB\n", ($3/1024)/1024);}')"
printColour "RAM_FREE" "$(grep MemFree /proc/meminfo | awk '{printf("%.3f GB\n", ($2/1024)/1024);}')"
printColour "SPACE_ROOT" "$(df -k / | awk '/\// {printf("%0.2f MB", $2 / 1024)}')"
printColour "SPACE_ROOT_USED" "$(df -k / | awk '/\// {printf("%0.2f MB", $3 / 1024)}')"
printColour "SPACE_ROOT_FREE" "$(df -k / | awk '/\// {printf("%0.2f MB", $4 / 1024)}')"

