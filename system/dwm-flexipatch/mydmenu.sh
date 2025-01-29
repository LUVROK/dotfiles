#!/bin/sh

get_path_for_entry() {
	for dir in ${XDG_DATA_DIRS//:/ }; do
		find "$dir/applications" -name "$1.desktop" 2>/dev/null;
	done
}
exec_desktop() {
	while read path; do
		${SHELL:-"/bin/sh"} -c "exec $(grep -oP '(?<=Exec=).*' $path)"
	done < "/dev/stdin"
}
selected=$(dmenu_run | dmenu "$@")
get_path_for_entry "$selected" | exec_desktop &