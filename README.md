# HMG-Seogaemo module template

Start a module for [HMG-Seogaemo](https://github.com/seogaemo/hmg-seogaemo): press
**Use this template**, edit `module/`, then build a package.

```sh
python3 tools/pack.py      # dist/<id>-<version>.hsm and its SHA-256
sh tools/push.sh           # install over adb on a head unit with HMG-Seogaemo
```

Tagging `v*` publishes the `.hsm` as a GitHub Release asset.
Tag `v<version>` must equal `version` in `module/module.properties`. One-shot modules (a single card button, `kind=action`) are described in `AGENTS.md`.
See `AGENTS.md` for the module format (also the right file to give an AI assistant).

## 한국어

HMG-Seogaemo 모듈을 만들기 위한 템플릿이다. `module/` 폴더만 고치면 된다.
`apply.sh`는 셸이 아니고 정해진 동사만 쓸 수 있으며, 모듈을 끄면 기록된 변경이 전부 원래대로 돌아간다.
