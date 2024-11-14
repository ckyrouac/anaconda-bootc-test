This is an experimental repo for testing bootc LBIs with anaconda. It has some helpers for setting up a dev/test environment.

First download the Fedora 41 network install ISO into the resources directory. Modify `create.sh` to point to your local copies of bootc and rpm-ostree. Then, use `create.sh` to spin up a VM via ks.cfg and `delete.sh` to remove it.

WIP code:
[bootc](https://github.com/ckyrouac/bootc/tree/no-container-install)
[rpm-ostree](https://github.com/ckyrouac/rpm-ostree/tree/anaconda-test)
[ostree-rs-ext](https://github.com/ckyrouac/ostree-rs-ext/tree/anaconda-test)
