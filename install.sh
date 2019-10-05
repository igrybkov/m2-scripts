#!/bin/bash

BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"
COPY="${COPY:-0}"
SCRIPTS_DIR="$(pwd)/scripts"
FORCE="${FORCE:-0}"

green() { echo -e "$(tput setaf 2)$*$(tput sgr0)"; }
yellow() { echo -e "$(tput setaf 3)$*$(tput sgr0)"; }
cyan() { echo -e "$(tput setaf 6)$*$(tput sgr0)"; }

mkdir -p "$BIN_DIR"
echo
green "Installing scripts"
find $SCRIPTS_DIR -mindepth 1 -maxdepth 1 \
  | while read line; do

    cd -- "$(dirname "$line")"

    ORIGIN="$(pwd)/$(basename "$line")"
    DEST="$BIN_DIR/$(basename "$line")"

    if [ "$FORCE" == "1" ]; then
      rm -f "$DEST"
    fi
    
    if [ -f "$DEST" ] || [ -d "$DEST" ]; then
      cyan "Destination already exists: $DEST"
    elif [ "$COPY" == "1" ]; then
      green "Copying file $line to $DEST"
      cp "$ORIGIN" "$DEST"
    else
      green "Linking file $line as $DEST"
      ln -s "$ORIGIN" "$DEST"
    fi

    cd "$BASEDIR"
done

echo
yellow "Don't forget to add \"${BIN_DIR}\" to you PATH"
