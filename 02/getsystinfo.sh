#/bin/bash

echo "HOSTNAME = " $(hostname)
echo "TIMEZONE = $(timedatectl | grep "Time zone" | awk '{print $3}') UTC $(date +%:::z)";
echo "USER = " $(whoami);
echo "OS =" $(hostnamectl | grep "Operating System" | awk '{printf ("%s\t%s\t%s", $3, $4, $5)}')
echo "DATE =" $(date +"%d %B %Y %T")
echo "UPTIME =" $(uptime -p | cut -f2- -d' ')
echo "UPTIME_SEC =" $(cat /proc/uptime | awk '{printf ("%i", $1)}')
echo "IP = " $(hostname -I | awk '{print $1}')
maskshort=$(ip -o -f inet addr show | awk '/scope global/ {print $4}' | cut -d'/' -f2 )
mask=$((0xffffffff << (32 - maskshort))); shift
ui32=$mask; shift
  for n in 1 2 3 4; do
      ipaddr=$((ui32 & 0xff))${ipaddr:+.}$ipaddr
      ui32=$((ui32 >> 8))
  done
echo "MASK =" $ipaddr
echo "GATEWAY =" $(/sbin/ip route | awk '/default/ { print $3 }')
echo "RAM_TOTAL =" $(grep MemTotal /proc/meminfo | awk '{printf("%.3f GB\n", ($2/1024)/1024);}')
echo "RAM_USED =" $(free | grep Mem: | awk '{printf("%.3f GB\n", ($3/1024)/1024);}')
echo "RAM_FREE =" $(grep MemFree /proc/meminfo | awk '{printf("%.3f GB\n", ($2/1024)/1024);}')
echo "SPACE_ROOT =" $(df -k / | awk '/\// {printf("%0.2f MB", $2 / 1024)}')
echo "SPACE_ROOT_USED =" $(df -k / | awk '/\// {printf("%0.2f MB", $3 / 1024)}')
echo "SPACE_ROOT_FREE =" $(df -k / | awk '/\// {printf("%0.2f MB", $4 / 1024)}')
