# Runs as root through the HMG-Seogaemo restricted interpreter, not a shell.
# Every write below is recorded and undone exactly when the module is turned off.
set_prop persist.sys.example.level {setting:level}
if setting_is level high; then
    log "high level selected"
fi
