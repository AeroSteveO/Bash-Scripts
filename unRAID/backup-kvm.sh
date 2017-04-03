#!/bin/bash
list=$(virsh list --name)
#list=$(echo $list | awk '{print tolower($0)}')
backupDir=/mnt/user/Backup/VM

# Setup directories needed
if [ ! -d $backupDir/`date +%Y%m%d` ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir $backupDir/`date +%Y%m%d`
fi




for VM_NAME in $list
do

LC_VM_NAME=$(echo $VM_NAME | awk '{print tolower($0)}')

echo $VM_NAME
echo $LC_VM_NAME


# Freeze guest filesystems
virsh domfsfreeze $VM_NAME

# Create snapshot
#qemu-img create -f qcow2 -b $VM_NAME.qcow2 $backupDir/$VM_NAME-`date +%Y%m%d`.qcow2
qemu-img convert -c -O qcow2 $vmDir/$LC_VM_NAME/vdisk1.qcow2 $backupDir/`date +%Y%m%d`/$1.qcow2

# Thaw guest filesystems
virsh domfsthaw $VM_NAME

# Take backup from snapshot
#qemu-img convert -O raw snapshot.qcow2 /backup/backup.img

done
