# !/bin/sh

script=$(basename -- "$0")

if [ "$#" -lt 2 ]; then
	echo "Expect 2 parameters. Usage example: ./${script} <kernel_path> <image_path> <local_internet_interface>"
	exit 1
fi

KERNEL=${1-""}
ROOTFS=${2-""}

set_mem_size() {
    if [ ! -z "$mem_set" ] ; then
        #Get memory setting size from user input
        mem_size=`echo $mem_set | sed 's/-m[[:space:]] *//'`
    else
        mem_size=$1
    fi
    # QEMU_MEMORY has 'M' appended to mem_size
    QEMU_MEMORY="$mem_size"M

}

config_qemuarm64() {
    set_mem_size 2048
    QEMU=qemu-system-aarch64

    QEMU_NETWORK_CMD="-nic user "
    DROOT="/dev/vda"
    ROOTFS_OPTIONS="-drive id=disk0,file=$ROOTFS,if=none,format=raw -device virtio-blk-device,drive=disk0"

    export QEMU_AUDIO_DRV="none"
    if [ "x$SERIALSTDIO" = "x" ] ; then
        QEMU_UI_OPTIONS="-nographic"
    else
        QEMU_UI_OPTIONS=""
    fi

    KERNCMDLINE="root=$DROOT rw console=ttyAMA0,38400 mem=$QEMU_MEMORY highres=off $KERNEL_NETWORK_CMD"
    # qemu-system-aarch64 only support '-machine virt -cpu cortex-a57' for now
    QEMUOPTIONS="$QEMU_NETWORK_CMD -machine virt -cpu cortex-a57 $ROOTFS_OPTIONS $QEMU_UI_OPTIONS -smp 4 "
}

config_qemuarm64

QEMU_FIRE="$QEMU -kernel $KERNEL $QEMUOPTIONS $SLIRP_CMD $SERIALOPTS -no-reboot $SCRIPT_QEMU_OPT $SCRIPT_QEMU_EXTRA_OPT"
echo $QEMU_FIRE -append '"'$KERNCMDLINE $SCRIPT_KERNEL_OPT'"'
LD_PRELOAD="$GL_LD_PRELOAD" $QEMU_FIRE -append "$KERNCMDLINE $SCRIPT_KERNEL_OPT"

wait
