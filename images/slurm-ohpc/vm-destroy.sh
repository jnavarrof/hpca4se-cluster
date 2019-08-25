export VM=slurm-ohpc
cd $IMAGES/$VM
virsh shutdown $VM
virsh undefine $VM
virsh pool-destroy $VM  

