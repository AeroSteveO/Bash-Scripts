#!/bin/bash
list=$(virsh list --inactive --name)
list=$(echo $list | awk '{print tolower($0)}')
backupDir=/mnt/user/Backup/VM
vmDir=/mnt/user/VM


if [ ! -d $backupDir/`date +%Y%m%d` ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir $backupDir/`date +%Y%m%d`
fi




#cd vmDir
for VM_NAME in $list
do
echo $VM_NAME

  # Create snapshot
  qemu-img convert -c -O qcow2 $vmDir/$VM_NAME/vdisk1.qcow2 $backupDir/`date +%Y%m%d`/$VM_NAME.qcow2

done
