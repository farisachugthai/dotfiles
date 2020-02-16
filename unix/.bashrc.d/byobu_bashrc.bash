#    byobu's bashrc -- colorize the prompt
#    Copyright (C) 2014 Dustin Kirkland
#
#    Authors: Dustin Kirkland <kirkland@byobu.org>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, version 3 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Ensure that we're in a tmux or screen session
case "$TERM" in
	xterm)
		# Try to ensure we have 256 colors
		export TERM="xterm-256color"
	;;
esac
if [ -n "$TMUX" ] || [ "${TERMCAP#*screen}" != "${TERMCAP}" ]; then
	# Ensure that we're in bash, in a byobu environment
	if [ -n "$BYOBU_BACKEND" ] && [ -n "$BASH" ]; then
		byobu_prompt_status() { local e=$?; [ $e != 0 ] && echo -e "$e "; }
		[ -n "$BYOBU_CHARMAP" ] || BYOBU_CHARMAP=$(locale charmap 2>/dev/null || echo)
		byobu_prompt_symbol() {
			if [ "$USER" = "root" ]; then
				printf "%s" "#";
			else
				printf "%s" "\$"
			fi
		}
		case "$BYOBU_DISTRO" in
			"Ubuntu")
				# Use Ubuntu colors (grey / orange / aubergine)
				PS1="${debian_chroot:+($debian_chroot)}\[\e[38;5;202m\]\$(byobu_prompt_status)\[\e[38;5;245m\]\u\[\e[00m\]@\[\e[38;5;172m\]\h\[\e[00m\]:\[\e[38;5;5m\]\w\[\e[00m\]\$(byobu_prompt_symbol) "
				# Use Ubuntu themed dircolors
				if [ -e "${BYOBU_PREFIX}/share/byobu/profiles/dircolors" ]; then
					dircolors "${BYOBU_PREFIX}/share/byobu/profiles/dircolors" > "$BYOBU_RUN_DIR/dircolors"
					. "$BYOBU_RUN_DIR/dircolors"
				fi
			;;
			*)
				# Use nice colors (green / red / blue)
				PS1="${debian_chroot:+($debian_chroot)}\[\e[31m\]\$(byobu_prompt_status)\[\e[00;32m\]\u\[\e[00m\]@\[\e[00;31m\]\h\[\e[00m\]:\[\e[00;36m\]\w\[\e[00m\]\$(byobu_prompt_symbol) "
			;;
		esac
	fi
fi
