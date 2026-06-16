#!/usr/bin/env bash

SOUNDS_DIR="$HOME/.config/hypr/scripts/sounds"

if [ ! -d "$SOUNDS_DIR" ]; then
  exit 1
fi

AUDIO_FILE=$(find "$SOUNDS_DIR" -maxdepth 1 -type f \( -name "*.mp3" -o -name "*.wav" -o -name "*.ogg" -o -name "*.flac" \) | shuf -n 1)

if [ -n "$AUDIO_FILE" ]; then
  ffplay -nodisp -autoexit -loglevel quiet "$AUDIO_FILE"
fi
