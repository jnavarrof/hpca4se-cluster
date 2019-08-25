export VM=slurm-vm1
cd $IMAGES/$VM
virsh shutdown $VM
virsh undefine $VM
virsh pool-destroy $VM  

