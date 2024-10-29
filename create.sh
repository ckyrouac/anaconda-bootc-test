#!/bin/bash

virt-install \
--name anaconda-bootc-test \
--vcpus 4 \
--ram 4096 \
--disk size=40 \
--location ./resources/rhel-9.4-x86_64-boot.iso \
--os-variant rhel9.4 \
--initrd-inject=./ks.cfg \
--autoconsole text \
--extra-args "inst.ks=file:/ks.cfg console=ttyS0"
