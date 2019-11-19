#!/bin/bash

source ../global.vars
mkdir deb 2>/dev/null

GIT_REF="706182e"

if [ ! -d check_lsi_raid ] ; then
  git clone https://github.com/mysociety/check_lsi_raid.git
fi
cd check_lsi_raid
git fetch
git checkout $GIT_REF
cd ..

VERSION="2.5"
ITERATION="ms1"

if [ -e deb/monitoring-plugins-lsi-raid_${VERSION}-${ITERATION}_amd64.deb ] ; then
  echo "==> Debian package for ${VERSION}-${ITERATION} already exists."
  exit 1
fi

bundle exec fpm -s dir -t deb \
  --vendor "${VENDOR}" \
  --maintainer "${MAINTAINER}" \
  --version "${VERSION}" \
  --iteration "${ITERATION}" \
  --license "GPL-3.0" \
  --description "Nagios/Icinga plugin to check LSI RAID Controllers" \
  --url "https://www.thomas-krenn.com/en/wiki/LSI_RAID_Monitoring_Plugin" \
  -d libfile-which-perl \
  -d monitoring-plugins \
  -p ./deb/ \
  -n "monitoring-plugins-lsi-raid" \
  ./check_lsi_raid/check_lsi_raid=/usr/lib/nagios/plugins/check_lsi_raid
