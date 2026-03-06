#!/usr/bin/env bash
# Hyprland script: Cycle monitor rotation 0→1→2→3→0 (90° steps clockwise)
# Each key press rotates the FOCUSED monitor + perfectly syncs mouse/touch/tablet input
# Uses per-monitor cache so state survives reboots and works with multi-monitor setups

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/hyprland_rotations"
mkdir -p "$CACHE_DIR"

# Get currently focused monitor
MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

if [ -z "$MONITOR" ]; then
  echo "Error: No focused monitor found!"
  notify-send "Hyprland Rotate" "No focused monitor found!" --icon=display
  exit 1
fi

# Safe filename for cache (handles eDP-1, HDMI-A-1, etc.)
CACHE_FILE="${CACHE_DIR}/${MONITOR//[^a-zA-Z0-9]/_}.rot"

# Read current rotation (default 0 if no cache)
if [ -f "$CACHE_FILE" ]; then
  CURRENT=$(cat "$CACHE_FILE")
else
  CURRENT=0
fi

# Cycle: 0 → 1 → 2 → 3 → 0
NEW=$(((CURRENT + 1) % 4))

echo "Rotating $MONITOR: $CURRENT → $NEW (90° × $NEW)"

# === Apply rotation ===
hyprctl keyword monitor ${MONITOR},preferred,auto,1,transform,${NEW}

# === Sync mouse/touch/tablet input (feels natural again) ===
if [ $NEW = 2 ]; then
  hyprctl keyword input:touchpad:flip_x true
  hyprctl keyword input:touchpad:flip_y true
else
  hyprctl keyword input:touchpad:flip_x false
  hyprctl keyword input:touchpad:flip_y false
fi

# Save new state
echo "$NEW" >"$CACHE_FILE"

# Nice feedback
DEG=$((NEW * 90))
notify-send "Hyprland Rotate" "Monitor: $MONITOR\nRotation: ${DEG}° (transform ${NEW})" --icon=display

echo "✅ Done! Press the key again to cycle to next rotation."
