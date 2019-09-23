#!/usr/bin/env bash

for snapshot in `zfs list -H -t snapshot -r "$1" | cut -f 1`
do
    zfs destroy "$snapshot"
done
