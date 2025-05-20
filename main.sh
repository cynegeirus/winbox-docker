#!/bin/bash

CPU=${CPU:-1}
RAM=${RAM:-2G}
RDP_PORT=${RDP_PORT:-3389}
VNC_DISPLAY=${VNC_DISPLAY:-2}
DISK_SIZE=${DISK_SIZE:=20G}

if [ ! -f /vm/os.qcow2 ]; then
  qemu-img create -f qcow2 /vm/os.qcow2 $DISK_SIZE
fi

qemu-system-x86_64 \
    -enable-kvm \
    -m ${RAM} \
    -cpu host \
    -smp ${CPU} \
    -drive file=/machine/os.qcow2,format=qcow2 \
    -cdrom /iso/os.iso \
    -drive file=/iso/virtio.iso,media=cdrom \
    -boot d \
    -netdev user,id=net0,hostfwd=tcp::${RDP_PORT}-:3389 \
    -device e1000,netdev=net0 \
    -vnc :${VNC_DISPLAY},password=off
