export IMAGES=/var/lib/libvirt/images
export VM=login-01
mkdir -p $IMAGES/$VM
cd $IMAGES/$VM

# copy from centos-1905 with a 20GB disk
BASEIMAGE=/var/lib/libvirt/boot/CentOS-7-x86_64-GenericCloud-1905.qcow2
cp $BASEIMAGE $IMAGES/$VM/$VM.qcow2
export LIBGUESTFS_BACKEND=direct
qemu-img create -f qcow2 -o preallocation=metadata $VM.new.image 20G
virt-resize --quiet --expand /dev/sda1 $VM.qcow2 $VM.new.image

# Overwrite it resized image:
mv $VM.new.image $VM.qcow2

# Pool
virsh pool-create-as --name $VM --type dir --target $IMAGES/$VM

# Creating a cloud-init ISO
mkisofs -o $VM-cidata.iso -V cidata -J -r user-data meta-data network-config.yml

## Installing a CentOS 7 VM
virt-install --import --name $VM \
--memory 1024 --vcpus 1 --cpu host \
--disk $VM.qcow2,format=qcow2,bus=virtio \
--disk $VM-cidata.iso,device=cdrom \
--network bridge=br1,model=virtio \
--os-type=linux \
--os-variant=centos7.0 \
--graphics spice \
--noautoconsole

# Eject media
virsh change-media $VM hda --eject --config
