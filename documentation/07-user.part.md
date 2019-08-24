## Users management

### Add/remove system Users
Edit this playbook `/root/hpca4se-config/ansible/users.yml` and add/remove users and groups from the vars section:

    vars:
        hpca4se_groups: [ 'g_hpca4se']
        hpca4se_users:
        - "jnavarro"
        hpca4se_delete_users:
        - "foo"
        - "bar"

Then, apply the playbook:

    source ~/.venv-ansible/bin/activate
    cd /root/hpca4se-config/ansible
    ansible-playbook playbooks/users.yml


By default this playbook add a SSH key (`authorized_key`) for all users. Now it is the same key for all users, but a ssh key could be created for every user, so that you will be able to use a custom temporal key as a temporary password:

    # Create a SSH key for the `foo`user
    cd /root/hpca4se-config/ansible
    ssh-keygen -t rsa -f playbooks/keys/hpca4se_foo_rsa


### Process to add the `foo` user
```bash
# Edit playbook vars and add the foo user to the list
vim `/root/hpca4se-config/ansible/users.yml

    vars:
        hpca4se_groups: [ 'g_hpca4se']
        hpca4se_users:
        - "jnavarro"	# An existing user. Do not remove from list
	- "foo"		# This is the new user

# Apply the playbook:
source ~/.venv-ansible/bin/activate
cd /root/hpca4se-config/ansible
ansible-playbook playbooks/users.yml

# Check user has been created in slurm and in one of the NIS clients
NEWUSER=foo
ssh -i ~/.ssh/vm-admin centos@slurm-ohpc "id $NEWUSER"
uid=1004(foo) gid=1005(foo) groups=1001(g_hpca4se),1005(foo)
ssh -i ~/.ssh/vm-admin centos@login01 "id $NEWUSER"
uid=1004(foo) gid=1005(foo) groups=1001(g_hpca4se),1005(foo)
```

### Process to remove the `foo` user
```bash
# Edit playbook vars and remove  the foo user from the `hpcsa4se_users` list 
# and add it to the `hpca4se_delete_users`
vim `/root/hpca4se-config/ansible/users.yml

    vars:
        hpca4se_groups: [ 'g_hpca4se']
        hpca4se_users:
        - "jnavarro"
        hpca4se_delete_users:
        - "foo"		# user to remove

# Apply the playbook:
source ~/.venv-ansible/bin/activate
cd /root/hpca4se-config/ansible
ansible-playbook playbooks/users.yml

# Check user has been removed in slurm and in one of the NIS clients
DELUSER=foo
ssh -i ~/.ssh/vm-admin centos@slurm-ohpc "id $DELUSER"
id: foo: no such user
ssh -i ~/.ssh/vm-admin centos@login01 "id $DELUSER"
id: foo: no such user
```


