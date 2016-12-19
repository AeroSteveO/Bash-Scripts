#!/bin/bash
list=$(virsh list --name)
list=$(echo $list | awk '{print tolower($0)}')
backupDir=/mnt/user/Backup/VM


for VM_NAME in $list
do
# Freeze guest filesystems
virsh domfsfreeze $VM_NAME

# Create snapshot
qemu-img create -f qcow2 -b $VM_NAME.qcow2 $backupDir/$VM_NAME-`date +%Y%m%d`.qcow2

# Thaw guest filesystems
virsh domfsthaw $VM_NAME

# Take backup from snapshot
#qemu-img convert -O raw snapshot.qcow2 /backup/backup.img

done
