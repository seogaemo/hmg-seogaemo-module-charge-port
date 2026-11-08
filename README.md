# Charge port (HMG-Seogaemo module)

One-shot module for [HMG-Seogaemo](https://github.com/seogaemo/hmg-seogaemo): a single **Open** button on the
Features screen that opens the charge port door of an electric vehicle. Hyundai Ioniq 5, Korea
(`NEEV.KOR.*.260902`) only. It has no on/off state and changes nothing on the head unit; it sends one factory
Binder call (`com.hkmc.micom.bcm` transaction 84, `requestChargeLockDoor`) and records it in the ledger.

Needs an HMG-Seogaemo version that supports `kind=action` modules. The door is closed by hand. Use only while parked.
Not yet verified on a car.

```sh
python3 tools/pack.py      # dist/charge-port-open-<version>.hsm and its SHA-256
sh tools/push.sh           # install over adb
```

Tagging `v0.1.0` (must equal `version`) publishes the `.hsm` as a GitHub Release asset.

## 한국어

HMG-Seogaemo 홈 화면에 "열기" 버튼 하나를 추가하는 모듈로, 전기차 충전 포트 도어를 엽니다.
현대 아이오닉 5(국내, `NEEV.KOR.*.260902`)만 지원합니다. 켜기/끄기 없이 버튼만 있고, 기기 설정은 바꾸지 않습니다.
닫기는 손으로 합니다. 정차 중에만 사용하세요. 아직 차에서 확인하지 않았습니다.
