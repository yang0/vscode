#!/usr/bin/env bash
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.

function realpath() {
	OS_VERSION=$(sw_vers -productVersion)
	PYTHON_PATH=$(which python)
	# Switch to use python3 on macOS >= 12 since python 2.7 is deprecated
	# https://developer.apple.com/documentation/macos-release-notes/macos-12_0_1-release-notes
	if [ ${OS_VERSION%%.*} -ge 12 ]; then
		PYTHON_PATH=$(which python3)
	fi
	"$PYTHON_PATH" -c "import os,sys; print(os.path.realpath(sys.argv[1]))" "$0";
}
CONTENTS="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")")"
ELECTRON="$CONTENTS/MacOS/Electron"
CLI="$CONTENTS/Resources/app/out/cli.js"
ELECTRON_RUN_AS_NODE=1 "$ELECTRON" "$CLI" --ms-enable-electron-run-as-node "$@"
exit $?
