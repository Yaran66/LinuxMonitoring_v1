#/bin/bash

echo "Total number of folders (including all nested ones) = " $(find $1 -type d | wc -l)
echo "TOP 5 folders of maximum size arranged in descending order (path and size): "
du -h $1 | sort -hr | cat -n | awk 'NR > 1' | awk 'FNR <= 5' | awk '{printf("%i - %s/, %s\n",($1 - 1), $3, $2);}'
echo "Total number of files = " $(find $1 -type f | wc -l)
echo "Number of:  "
echo "Configuration files (with the .conf extension) =" $(find $1 -type f -name "*.conf" | wc -l)
echo "Text files =" $(find $1 -type f -name "*.txt" | wc -l)
echo "Executable files =" $(find $1 -type f -executable | wc -l)
echo "Log files (with the extension .log) =" $(find $1 -type f -name "*.log" | wc -l)
echo "Archive files = " $(find $1 -type f -name "*.tar" -or -name "*.gzip" -or -name "*.gz" -or -name "*.bz2" -or -name "*.zip" -or -name "*.7z" -or -name "*.iso" -or -name "*.rar" | wc -l)
echo "Symbolic links = " $(find $1 -type l | wc -l)
echo "TOP 10 files of maximum size arranged in descending order (path, size and type): "
i=1
Files10Big=$(find $1 -type f -printf '%s %p\n' | sort -rn | cat -n | awk 'FNR <= 10' | awk '{ "numfmt --to=iec " $2 | getline result; printf("%i %s %sB\n",$1, $3, result);}')
while [ $i -le 10 ]
do
NbrPathSize=$(cat <<< $Files10Big | awk -v var="$i" '{ if (FNR == var) printf("%i - %s, %s",$1, $2, $3);}')
Extension=$(cat <<< $Files10Big | awk '{print $2}' | awk -v var="$i" -F. '{ if (FNR == var) printf("%s\n",$NF);}')
echo "$NbrPathSize", "$Extension"
i=$(( $i + 1 ))
done

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file) "
i=1
FileExec10Big=$(find $1 -type f -executable -printf '%s %p\n' | sort -rn | cat -n | awk 'FNR <= 10' | awk '{ "numfmt --to=iec " $2 | getline result; printf("%i %s %sB\n",$1, $3, result);}')
while [ $i -le 10 ]
do
NbrPathSize=$(cat <<< $FileExec10Big | awk -v var="$i" '{if (FNR == var) printf("%i - %s, %s",$1, $2, $3);}')
md5sumHash=$(cat <<< $FileExec10Big | awk -v var="$i" '{ "md5sum " $2 | getline result ; if (FNR == var) print result;}' | awk '{print $1}')
echo "$NbrPathSize", "$md5sumHash"
i=$(( $i + 1 ))
done

