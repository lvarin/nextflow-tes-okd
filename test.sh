#!/bin/bash
#

NF=$1

if [ -z "$NF" ];
then
	NF="$(find /tmp/nf/ -type f -name *.nf)"
fi

set -x
for nf in $NF;
do
  /usr/local/bin/nextflow run $nf -with-docker centos -w /mnt
done
set +x
