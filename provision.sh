#!/bin/bash
 
# reference
# http://www.moyashi-koubou.com/blog/vagrant_ansible_windows/

ANSIBLE_PLAYBOOK=${1}
ANSIBLE_HOSTS=${2}
TEMP_HOSTS="/tmp/ansible_hosts"
 
if [ ! -f /vagrant/$ANSIBLE_PLAYBOOK ]; then
  echo "Cannot find Ansible playbook"
  exit 1
fi
 
if [ ! -f /vagrant/$ANSIBLE_HOSTS ]; then
  echo "Cannot find Ansible hosts"
  exit 2
fi
 
if ! [ `which ansible` ]; then
  sudo apt-get install -y ansible
fi
 
cp /vagrant/${ANSIBLE_HOSTS} ${TEMP_HOSTS} && chmod -x ${TEMP_HOSTS}
echo "Running Ansible"
bash -c "ansible-playbook /vagrant/${ANSIBLE_PLAYBOOK} --inventory-file=${TEMP_HOSTS} --connection=local"
rm ${TEMP_HOSTS}
