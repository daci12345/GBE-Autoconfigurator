# GBE-Autoconfigurator
Small bash script for the goldberg steam emulator

I recommend you using [this](https://github.com/otavepto/gbe_fork) fork of goldberg emu, but this script expects the same this structure as the original goldberg release [here](https://mr_goldberg.gitlab.io/goldberg_emulator/).

The script is really simple to use, just point the EMU_DIR variable in the script to the extracted location, and use it like here:
1. copy the script next to the original steam_api dll/so file
2. run the script like this:
```
APPID=1337 bash goldberg.sh
