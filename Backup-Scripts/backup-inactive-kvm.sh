#!/bin/bash
# Backs up currently inactive KVM virtual machines (in qcow2 format at the moment)
# Freezes the VM, copies and compresses the disk image to the backup location, and unfreezes the VM
# Does not properly handle multiple disks for a single vm... yet


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

	for filename in $vmDir/$LC_VM_NAME/*.qcow2
	do
	  echo qemu-img convert -c -O qcow2 $filename $backupDir/`date +%Y%m%d`/$VM_NAME.qcow2
	  qemu-img convert -c -O qcow2 $filename $backupDir/`date +%Y%m%d`/$VM_NAME.qcow2
	done

done
