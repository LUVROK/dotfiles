//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"\x01",  "$HOME/HOME/dotfiles/system/dwmblocks-scripts/sb-lang.sh", 0, 1},
	{"\x02",  "$HOME/HOME/dotfiles/system/dwm-flexipatch/scripts/sb/sb-xmr.sh", 600, 2},
	{"\x03", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed 's/i//g' | sed 's/,/./g'",	10, 3},
	{"\x04", "$HOME/HOME/dotfiles/system/dwm-flexipatch/scripts/sb/sb-battery_status.sh", 30, 4},
	{"\x05", "$HOME/HOME/dotfiles/system/dwm-flexipatch/scripts/sb/sb-wifi-status.sh", 30, 5 },
	{"\x06", "date '+%H:%M:%S'", 60, 6},
	{"\x07", "$HOME/HOME/dotfiles/system/dwm-flexipatch/scripts/sb/sb-test.sh", 0, 7 },
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static unsigned int delimLen = 4;
static char *delim = " | ";