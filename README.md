# meta-aos-ewaol
Integration Aos Adapter with SOAFEE

## Dependency

  meta-arm:
    - url: git://git.yoctoproject.org/meta-arm

  meta-openembedded:
    - url: https://git.openembedded.org/meta-openembedded

## Git URL

  https://github.com/DmytroRozzuvailo/meta-aos-ewaol

## How to build

```
# install kas
sudo pip3 install kas
```


```
mkdir ~/soafee
cd ~/soafee

git clone https://github.com/DmytroRozzuvailo/meta-aos-ewaol-machine

export PATH_TO_WORKDIR=$(pwd)

cd meta-aos-ewaol-machine

./build.sh ewaol-aos-qemuarm64 baremetal

```


## How to run

```
.//meta-aos-ewaol/scripts/qemu_start.sh ${PATH_TO_WORKDIR}/meta-aos-ewaol-machine/build/ewaol-aos-qemuarm64/tmp_baremetal/deploy/images/ewaol-aos-qemuarm64/Image ${PATH_TO_WORKDIR}/meta-aos-ewaol-machine/build/ewaol-aos-qemuarm64/tmp_baremetal/deploy/images/ewaol-aos-qemuarm64/ewaol-aos-vm-image-ewaol-aos-qemuarm64.ext4
```
