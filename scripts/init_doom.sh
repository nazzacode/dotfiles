#/bin/sh
DOOM="$HOME/.emacs.d"

if [ ! -d "$DOOM" ]; then
	git clone --depth 1 https://github.com/hlissner/doom-emacs.git $DOOM
	$DOOM/bin/doom -y install
fi

$DOOM/bin/doom sync
