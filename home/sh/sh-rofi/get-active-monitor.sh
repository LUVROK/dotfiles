# !/bin/sh

OFFSET_RE="\+([-0-9]+)\+([-0-9]+)"

# Get the window position
X=$(xdotool getmouselocation | awk -F: '{print $2}' | awk '{print $1}')
Y=$(xdotool getmouselocation | awk -F: '{print $3}' | awk '{print $1}')

# Loop through each screen and compare the offset with the window
# coordinates.
monitor_index=0
while read name width height xoff yoff
do
    if [ "${X}" -ge "$xoff" \
      -a "${Y}" -ge "$yoff" \
      -a "${X}" -lt "$(($xoff+$width))" \
      -a "${Y}" -lt "$(($yoff+$height))" ]
    then
        monitor=$name
        widthM=$width
        break
    fi
    ((monitor_index++))
done < <(xrandr | grep -w connected |
    sed -r "s/^([^ ]*).*\b([-0-9]+)x([-0-9]+)$OFFSET_RE.*$/\1 \2 \3 \4 \5/" |
    sort -nk4,5)

# If we found a monitor, echo it out, otherwise print an error.
if [ ! -z "$monitor" ]; then
    echo $monitor
    echo $widthM
    exit 0
else
    echo "Couldn't find any monitor for the current window." >&2
    exit 1
fi