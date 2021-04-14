Run the following role with
ansible-playbook roles.yml -K (If NOPASSWD is not there else -K can be ignored)

1) Check for ONBOOT parameter
2) Check for rhel repos (this is for centos)

Things did:
1) yum install ansible -y
2) add hosts and vars to hosts
3) Divided tasks into three playbooks with 1 handler for yum repolist

     i) gpg.yml -> This download the working repo and disbales gpgcheck cuz didnt find working gpgkey for it. It notifies handler repolist
     
     ii) yum.yml -> This update Cen to 6.10 making it download new kernel and patches to other packages.
     
     iii) restart.yml -> This takes a reboot for the new kernel to reflect and boot from and returns the variables stating what is the current kernel version it booted with.
     
