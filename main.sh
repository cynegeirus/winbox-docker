#!/bin/bash

CPU=${CPU:-1}
RAM=${RAM:-2G}
RDP_PORT=${RDP_PORT:-3389}
VNC_DISPLAY=${VNC_DISPLAY:-2}

qemu-img create -f qcow2 /machine/os.qcow2 20G

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
