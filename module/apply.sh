# One-shot: the only write is the factory Binder call, run when the card button is tapped.
# com.hkmc.micom.bcm tx 84 = requestChargeLockDoor(boolean); an empty argument reads false, which opens.
if action_is open; then
    call_service com.hkmc.micom.bcm 84
fi
