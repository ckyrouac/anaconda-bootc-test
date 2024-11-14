#!/bin/bash

# modify ostree-rs-ext
# override ostree-rs-ext dependency in rpm-ostree/Cargo.toml to point to local dir
# build bootc via make
# copy bootc binary into  resources/bootc.cfg
# build rpm-ostre via make
# copy rpm-ostree binary into  resources/rpm-ostree.cfg because
# for some reason initrd-inject only persists files with a .cfg extension?

set -e
set -x

BOOTC_REPO=/home/chris/projects/bootc
RPM_OSTREE_REPO=/home/chris/projects/rpm-ostree
ANACONDA_BOOTC_TEST_REPO=/home/chris/projects/anaconda-bootc-test

cd "$BOOTC_REPO" || exit
make
cp ./target/release/bootc "${ANACONDA_BOOTC_TEST_REPO}/resources/bootc.cfg"

cd "$RPM_OSTREE_REPO" || exit
make
cp ./target/release/rpm-ostree "${ANACONDA_BOOTC_TEST_REPO}/resources/rpm-ostree.cfg"

cd "$ANACONDA_BOOTC_TEST_REPO" || exit

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

