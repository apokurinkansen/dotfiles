#!/bin/bash
# OS に応じて音声を再生する
# Usage: play-sound.sh <sound_file>

SOUND_FILE="$1"

if [[ -z "$SOUND_FILE" ]]; then
    exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    afplay "$SOUND_FILE" &
elif command -v paplay &> /dev/null; then
    # Linux (WSL with PulseAudio)
    paplay "$SOUND_FILE" &
fi
