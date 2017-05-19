backupDir=/mnt/user/Backup/VM
vmDir=/mnt/user/VM

# Freeze guest filesystems
virsh domfsfreeze $1

# Create snapshot
#qemu-img create -f qcow2 -b $1.qcow2 $backupDir/$1-`date +%Y%m%d`.qcow2
qemu-img convert -Oc qcow2 $vmDir/$LC_VM_NAME/snapshot.qcow2 $backupDir/`date +%Y%m%d`/$VM_NAME.qcow2

# Thaw guest filesystems
virsh domfsthaw $1
