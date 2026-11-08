# Optional. Runs before the module is turned on.
if uses_on wifi.radio:sta; then
    warn @needs_hotspot
fi
