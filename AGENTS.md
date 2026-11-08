# Writing an HMG-Seogaemo module

This repository is one module for HMG-Seogaemo on Hyundai/Kia/Genesis Gen5W head units
(Android 4.4). The authoritative format is the "Installable module packages, API 1" section
of `.agents/installable-modules.md` in the HMG-Seogaemo repository (`.agents/module-runtime-contract.md` has the runtime rules).

## Files (all under `module/`)

- `module.properties`: `id`, `version` (N.N.N), `api=1`, `cars` (ro.build.product globs),
  optional `kind` (`toggle` default, or `action`, see below), `icon`, `restart`, `rerun_on`, `depends`, `uses`, `not_with`, `conflicts`,
  `stock_file.N=/path:md5`, `hookpoints`, `setting.N=key:type:default`
  (types `toggle`, `choice(a|b)`, `number(min..max)`). Unknown keys are refused.
- `apply.sh`: required. Not a shell. One verb per line plus `if/elif/else/fi`.
- `check.sh`, `status.sh`, `ui.txt`: optional.
- `strings/en.txt`: required, with `name` and `summary`. Other locales optional.
- `files/`: payload for `put_file`/`put_files`.

## apply.sh verbs

`set_prop [--reassert] KEY VALUE`, `put_file DEST files/SRC [MODE]`,
`put_files DESTDIR/ files/SRCDIR/ [MODE]`, `replace_line FILE "STOCK LINE" "NEW LINE"`,
`restart_service NAME`, `call_service SERVICE CODE`, `log TEXT`.
Conditions: `setting_is`, `prop_is`, `file_exists`, `file_missing`, `car_is`, `module_on`,
`hookpoints_ok`, `uses_on`, `action_is`, each optionally prefixed by `not`.
`{setting:KEY}` may replace a whole value token. Paths and property names must be literal.

## One-shot modules (`kind=action`)

For a module that only does something once per tap (open a door, trigger a call) and has nothing to switch on or
restore. Needs an HMG-Seogaemo version that supports `kind=action` (older ones refuse it as an unknown key).

- `module.properties`: `kind=action`. Forbidden with it: `setting.N`, `hookpoints`, `depends`, `not_with`,
  `rerun_on`, `stock_file.N`. Optional `icon`.
- `apply.sh` may use only `call_service`, inside `if action_is NAME; then ... fi`.
- `ui.txt` must start with the `button name=NAME label=@action_label confirm=@action_confirm` block the card runs.
- `strings/en.txt` (and `ko.txt`): `name`, `summary`, `action_label` (text of the card button), `action_confirm`
  (confirm question). The card shows no on/off state; every call is recorded in the ledger.
- A complete example is the `hmg-seogaemo-module-charge-port` repository.

## Release

Set `version` in `module/module.properties`, commit, then push a tag `v<version>` (it must equal `version`).
The `release` workflow packs the module and publishes the `.hsm` and its SHA-256 as a GitHub Release.
Install it by hand from the app (USB) or with `sh tools/push.sh`.

## Rules

- There is no revert script: turning the module off undoes every recorded write.
- Never try to run commands; anything that is not a verb refuses installation.
- Keep proper nouns as written (CarPlay, Android Auto, Wi-Fi, HMG-Seogaemo).
- Run `python3 tools/pack.py` and fix any `HSM-E` error reported at install.
