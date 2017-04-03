backupDir=/mnt/user/Backup/VM
vmDir=/mnt/user/VM

LC_VM_NAME=$(echo $1 | awk '{print tolower($0)}')


# Setup Directories
if [ ! -d $backupDir/`date +%Y%m%d` ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir $backupDir/`date +%Y%m%d`
fi


sz = qemu-img info /mnt/user/VM/$LC_VM_NAME/vdisk1.qcow2 | grep 'disk size:' | tr 'disk size:' ' '
qemu-img create  $backupDir/`date +%Y%m%d`/$1.qcow2 $sz


# Freeze guest filesystems
virsh domfsfreeze $1

# Create snapshot
#qemu-img create -f qcow2 -b $1.qcow2 $backupDir/$1-`date +%Y%m%d`.qcow2
qemu-img convert -c -O qcow2 $vmDir/$LC_VM_NAME/vdisk1.qcow2 $backupDir/`date +%Y%m%d`/$1.qcow2

# Thaw guest filesystems
virsh domfsthaw $1
