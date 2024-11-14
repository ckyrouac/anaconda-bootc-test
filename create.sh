#!/bin/bash

# modify ostree-rs-ext
# override ostree-rs-ext dependency in rpm-ostree/Cargo.toml to point to local dir
# build rpm-ostre via make
# copy rpm-ostree binary into  resources/rpm-ostree.cfg because
# for some reason initrd-inject only persists files with a .cfg extension?

set -e
set -x

cd /home/chris/projects/bootc || exit
make
cp ./target/release/bootc /home/chris/projects/anaconda-bootc-test/resources/bootc.cfg

cd /home/chris/projects/rpm-ostree || exit
make
cp ./target/release/rpm-ostree /home/chris/projects/anaconda-bootc-test/resources/rpm-ostree.cfg

cd /home/chris/projects/anaconda-bootc-test || exit

virt-install \
--name anaconda-bootc-test \
--vcpus 4 \
--ram 4096 \
--disk size=40 \
--location ./resources/Fedora-Server-netinst-x86_64-41-1.4.iso \
--os-variant rhel9.4 \
--initrd-inject=./ks.cfg \
--initrd-inject=./resources/rpm-ostree.cfg \
--initrd-inject=./resources/bootc.cfg \
--autoconsole text \
--extra-args "inst.ks=file:/ks.cfg console=ttyS0"

