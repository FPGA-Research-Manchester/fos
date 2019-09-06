#!/bin/bash

set -x
set -e

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Patching resolv.conf"
sudo mv $target/etc/resolv.conf $target/etc/resolv.conf.netplan
sudo cp $script_dir/resolv.conf $target/etc/
