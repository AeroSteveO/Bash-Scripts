#!/bin/bash

list=$(virsh list --name)
#list=$(echo $list | awk '{print tolower($0)}')
backupDir=/mnt/user/Backup/VM
vmDir=/mnt/user/VM



###################################################################

# Setup Directories
if [ ! -d $backupDir/`date +%Y%m%d` ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir $backupDir/`date +%Y%m%d`
fi

#####################################################################

#cd vmDir
for VM_NAME in $list
do

	LC_VM_NAME=$(echo $VM_NAME | awk '{print tolower($0)}')

	echo $VM_NAME
	echo $LC_VM_NAME



	for filename in /mnt/user/VM/$LC_VM_NAME/*.qcow2
	do
	  sz=$(qemu-img info $filename | grep 'disk size:' | tr 'disk size:' ' ')
	  echo qemu-img create $backupDir/`date +%Y%m%d`/$VM_NAME.qcow2 $sz
	  qemu-img create  $backupDir/`date +%Y%m%d`/$VM_NAME.qcow2 $sz
	done


	# Freeze guest filesystems
	virsh domfsfreeze $VM_NAME

	# Create snapshot
	#qemu-img create -f qcow2 -b $1.qcow2 $backupDir/$1-`date +%Y%m%d`.qcow2
	for filename in $vmDir/$LC_VM_NAME/*.qcow2
	do
	  echo qemu-img convert -c -O qcow2 $filename $backupDir/`date +%Y%m%d`/$VM_NAME.qcow2
	  qemu-img convert -c -O qcow2 $filename $backupDir/`date +%Y%m%d`/$VM_NAME.qcow2
	done

	# Thaw guest filesystems
	virsh domfsthaw $VM_NAME




done



