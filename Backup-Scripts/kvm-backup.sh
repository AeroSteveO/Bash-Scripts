#!/bin/bash

#Requires you to have qemu-guest-agent installed
# yum install qemu-guest-agent
# apt-get install qemu-guest-agent

guests=$(virsh list | grep running | awk '{print $2}')



# Freeze guest filesystems
virsh domfsfreeze $VM_NAME

# Create snapshot
qemu-img create -f qcow2 -b $VM_NAME.qcow2 snapshot.qcow2

# Thaw guest filesystems
virsh domfsthaw $VM_NAME

# Take backup from snapshot
qemu-img convert -O raw snapshot.qcow2 /backup/backup.img
