export VM=login-01
cd $IMAGES/$VM
virsh shutdown $VM
virsh undefine $VM
virsh pool-destroy $VM  

