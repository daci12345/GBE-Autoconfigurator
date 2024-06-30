#!/bin/bash
########################################################################
# Usage: APPID=736260 ./goldberg.sh	   			       #
# You need to set EMU_DIR to the extracted goldberg emulator directory.#
# To be able to use genconf get the scripts from the goldberg source   #
# code and put it in $EMU_DIR/scripts				       #
########################################################################

#config
EMU_DIR="/path/to/emu"

username() {
	mkdir -p steam_settings
	echo "jc141" > steam_settings/force_account_name.txt
}

native() {
	mv libsteam_api.so libsteam_api.so.orig
	if file libsteam_api.so.orig | grep -q "32-bit";
	then
		cp "$EMU_DIR/linux/x32/libsteam_api.so" libsteam_api.so
	else
		cp "$EMU_DIR/linux/x64/libsteam_api.so" libsteam_api.so
	fi
}

windows() {
	if [ -e steam_api64.dll ];
	then
		mv steam_api64.dll steam_api64.dll.orig && cp "$EMU_DIR/experimental/x64/steam_api64.dll" steam_api64.dll
	else
		mv steam_api.dll steam_api.dll.orig && cp "$EMU_DIR/experimental/x32/steam_api.dll" steam_api.dll
	fi
}

interfaces() {
	if [ -e libsteam_api.so ];
	then
		"$EMU_DIR/linux/tools/find_interfaces.sh" libsteam_api.so >> steam_interfaces.txt
	else
		"$EMU_DIR/linux/tools/find_interfaces.sh" steam_api*.dll >> steam_interfaces.txt
	fi
}

genconf() {
 "$EMU_DIR/scripts/generate_emu_config/generate_emu_config" $APPID && cp -r output/"$APPID"/steam_settings "$PWD" && cp -r output/"$APPID"/info "$PWD" && rm -rf output
}

if [ -e libsteam_api.so ];
then
	interfaces & sleep 1 && native && username && genconf
else
	interfaces & sleep 1 && windows && username && genconf
fi
