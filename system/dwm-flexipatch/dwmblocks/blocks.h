//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"| ",  "$HOME/HOME/dotfiles/system/dwm-flexipatch/scripts/lang.sh", 0, 1},
	{"",  "$HOME/HOME/dotfiles/system/dwm-flexipatch/scripts/_xmr.sh", 600, 0},
	{"", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed 's/i//g' | sed 's/,/./g'",	15, 0},
	{"", "$HOME/HOME/dotfiles/system/dwm-flexipatch/scripts/battery_status.sh", 30, 0},
	/* {"", "$HOME/HOME/dotfiles/system/dwm-flexipatch/dwmblocks/scripts/sb-internet.sh", 10, 9},*/
	{ "", "$HOME/HOME/dotfiles/system/dwm-flexipatch/scripts/wifi-status.sh", 30, 0 },
	{"", "date '+%H:%M'", 5, 0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
 