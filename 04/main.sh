#/bin/bash

if [[ $# -ne 0 ]]; then echo "Error! Arguments are not allowed ! Run the script without arguments !"
exit 1;
fi

source colour.conf #2>/dev/null

if [[ $? -ne 0 ]]; then
	echo "Error! bad format of config file! "
	exit 1;
fi

flag1=0
flag2=0
flag3=0
flag4=0


if [[ $column1_background -eq "" ]]; then
	column1_background=1
	flag1=1
	fi
if [[ $column1_font_color -eq "" ]]; then
	column1_font_color=2
	flag2=1
	fi
if [[ $column2_background -eq "" ]]; then
	column2_background=1
	flag3=1
	fi
if [[ $column2_font_color -eq "" ]]; then
	column2_font_color=2
	flag4=1
fi

REGEX1_6="^[1-6]$"

function colourCode {

case "$1" in
1) echo "white" ;; #1
2) echo "red" ;; #2
3) echo "green" ;; #3
4) echo "blue" ;; #4
5) echo "purple" ;; #5
6) echo "black" ;; #6
esac

}

function colourScheme {

if [[ flag1 -eq 1 ]]; then
	echo "Column 1 background = default ($(colourCode $column1_background))"
else echo "Column 1 background = $column1_background ($(colourCode $column1_background))"
fi

if [[ flag2 -eq 1 ]]; then
	echo "Column 1 font color = default ($(colourCode $column1_font_color))"
else echo "Column 1 font color = $column1_font_color ($(colourCode $column1_font_color))"
fi

if [[ flag3 -eq 1 ]]; then
	echo "Column 2 background = default ($(colourCode $column2_background))"
else echo "Column 2 background = $column2_background ($(colourCode $column2_background))"
fi

if [[ flag4 -eq 1 ]]; then
	echo "Column 2 font color = default ($(colourCode $column2_font_color))"
else echo "Column 2 font color = $column2_font_color ($(colourCode $column2_font_color))"
fi

}

# start to execute the script
if ! [[ $column1_background =~ $REGEX1_6 ]] || ! [[ $column1_font_color =~ $REGEX1_6 ]] || ! [[ $column2_background =~ $REGEX1_6 ]] || ! [[ $column2_font_color =~ $REGEX1_6 ]]; then
    echo "Error! Arguments should be numbers from 1 to 6 OR leave it blank to use default settings!"
elif [[ $column1_background -eq $column1_font_color ]] || [[ $column2_background -eq $column2_font_color ]]; then
    echo "Error! Arguments for font and background colours should be different. Default background - 1 - white. Default font - 2 - red. Try again or delete all colour numbers in config file to use default settings ! "
else ./getsystinfo.sh $column1_background $column1_font_color $column2_background $column2_font_color
      colourScheme
fi


