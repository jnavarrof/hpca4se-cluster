## OHPC Software management

### Install all OHPC package groups and packages

```bash
source ~/.venv-ansible/bin/activate
cd /root/hpca4se-config/ansible
ansible-playbook playbooks/ohpc-software.yml
```

#### Add new packages
Edit either the `ohpc_software_groups` or `ohpc_software_packages` variables and run the playbook again.


```bash
# Source and enter into the directory
source ~/.venv-ansible/bin/activate
cd /root/hpca4se-config/ansible

# Edit list or group of packages
vim playbooks/ohpc-software.yml
```
Edit playbook vars:
```yaml
  vars:
    ohpc_software_groups:
    - ohpc-autotools
    - ohpc-io-libs-gnu
    - ohpc-parallel-libs-gnu
    - ohpc-parallel-libs-gnu-mpich
    - ohpc-parallel-libs-gnu-mvapich2
    - ohpc-parallel-libs-gnu-openmpi
    - ohpc-perf-tools-gnu  # Your new @group

    ohpc_software_packages:
    - valgrind-ohpc
    - singularity  # Your new package
```

Run the playbook

```bash
# Apply the playbook again
ansible-playbook playbooks/ohpc-software.yml
```


### OHPC repository, group packages and packages installed by default

```yaml
  vars:
    ohpc_package_url: "http://github.com/openhpc/ohpc/releases/download/v1.3.GA/ohpc-release-1.3-1.el7.x86_64.rpm"
    ohpc_software_groups:
    - ohpc-autotools
    - ohpc-io-libs-gnu
    - ohpc-parallel-libs-gnu
    - ohpc-parallel-libs-gnu-mpich
    - ohpc-parallel-libs-gnu-mvapich2
    - ohpc-parallel-libs-gnu-openmpi
    - ohpc-perf-tools-gnu
    - ohpc-python-libs-gnu
    - ohpc-runtimes-gnu
    - ohpc-serial-libs-gnu

    ohpc_software_packages:
    - valgrind-ohpc
    - singularity
    - mlocate
    - lmod-ohpc
    - lmod-defaults-gnu-mpich-ohpc
    - lmod-defaults-gnu-openmpi-ohpc
```   

#### How to list packages installed from groups

```bash
cat<<-EOF >/tmp/packages 
ohpc-autotools
ohpc-io-libs-gnu
ohpc-parallel-libs-gnu
ohpc-parallel-libs-gnu-mpich
ohpc-parallel-libs-gnu-mvapich2
ohpc-parallel-libs-gnu-openmpi
ohpc-perf-tools-gnu
ohpc-python-libs-gnu
ohpc-runtimes-gnu
ohpc-serial-libs-gnu
EOF

cat /tmp/packages | xargs yum group info 
 [...]

 Description: OpenHPC parallel library builds for use with GNU compiler toolchain and the OpenMPI runtime
 Mandatory Packages:
   +boost-gnu-openmpi-ohpc
   +fftw-gnu-openmpi-ohpc
   +hypre-gnu-openmpi-ohpc
   +mumps-gnu-openmpi-ohpc
   +petsc-gnu-openmpi-ohpc
   +scalapack-gnu-openmpi-ohpc
   +superlu_dist-gnu-openmpi-ohpc
   +trilinos-gnu-openmpi-ohpc

Group: ohpc-perf-tools-gnu
 Group-Id: ohpc-perf-tools-gnu
 Description: OpenHPC performance tool builds for use with GNU compiler toolchain
 Mandatory Packages:
   +imb-gnu-mpich-ohpc
   +imb-gnu-mvapich2-ohpc
   +imb-gnu-openmpi-ohpc
   +mpiP-gnu-mpich-ohpc
   +mpiP-gnu-mvapich2-ohpc
   +mpiP-gnu-openmpi-ohpc
   +papi-ohpc
   +scalasca-gnu-mpich-ohpc
   +scalasca-gnu-mvapich2-ohpc
   +scalasca-gnu-openmpi-ohpc
   +tau-gnu-mpich-ohpc
   +tau-gnu-mvapich2-ohpc
   +tau-gnu-openmpi-ohpc

Group: ohpc-python-libs-gnu
 Group-Id: ohpc-python-libs-gnu
 Description: OpenHPC python related library builds for use with GNU compiler toolchain
 Mandatory Packages:
   +python-numpy-gnu-ohpc
   +python-scipy-gnu-mpich-ohpc
   +python-scipy-gnu-mvapich2-ohpc
   +python-scipy-gnu-openmpi-ohpc
   
Group: ohpc-runtimes-gnu
 Group-Id: ohpc-runtimes-gnu
 Description: OpenHPC runtimes for use with GNU compiler toolchain
 Mandatory Packages:
   +ocr-gnu-ohpc

Group: ohpc-serial-libs-gnu
 Group-Id: ohpc-serial-libs-gnu
 Description: OpenHPC serial library builds for use with GNU compiler toolchain
 Mandatory Packages:
   +gsl-gnu-ohpc
   +metis-gnu-ohpc
   +openblas-gnu-ohpc
   +superlu-gnu-ohpc
```

<div style="page-break-after: always;"></div>
