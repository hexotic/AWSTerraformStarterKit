#!/usr/bin/env bash

#
# // Software Name : AWSTerraformStarterKit
# // SPDX-FileCopyrightText: Copyright (c) 2023 Orange Business
# // SPDX-License-Identifier: BSD-3-Clause
# //
# // This software is distributed under the BSD License;
# // see the LICENSE file for more details.
# //
# // Author: AWS Practice Team <awspractice.core@orange.com>
#

set -o errexit -o nounset -o pipefail

# Set Starterkit version
STARTER_KIT_VERSION="${1:-latest}"
STARTER_KIT_PROJECT="${2:-Orange-OpenSource/AWSTerraformStarterKit}"

if [ "$STARTER_KIT_VERSION" == "latest" ]; then

    LOCATION=$(curl -s "https://api.github.com/repos/${STARTER_KIT_PROJECT}/releases/latest  \
    | grep "tag_name" \
    | awk '{print "https://github.com/${STARTER_KIT_PROJECT}/archive/" substr($2, 2, length($2)-3) ".zip"}') \
    ; curl -L -o /tmp/archive.zip "$LOCATION"
else
  curl  -L\
   "https://github.com/${STARTER_KIT_PROJECT}/archive/refs/tags/${STARTER_KIT_VERSION}.zip" \
  -o /tmp/archive.zip
fi

unzip /tmp/archive.zip -d .
cp -r AWSTerraformStarterKit-*/. .
rm -rf AWSTerraformStarterKit-*
rm /tmp/archive.zip
