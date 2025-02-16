# !/bin/sh

# this help get current active window width 
WIDTH=$(xdotool getactivewindow getwindowgeometry --shell | grep WIDTH | cut -d '=' -f2)
echo $WIDTH

