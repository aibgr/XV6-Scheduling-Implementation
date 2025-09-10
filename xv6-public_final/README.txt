\
ONE-SHOT XV6 PROJECT PACKAGE
----------------------------

Files in this archive are ready to be copied into your xv6-public source tree
and used to build the kernel and user programs needed for the OS project.

IMPORTANT: This archive will NOT automatically modify your syscall.c array entries
or Makefile. Scripts are provided to help apply the standard edits. Please read
the 'apply_patches.sh' script and the instructions below before running.

Installation (recommended safe steps):
1) Backup your xv6-public directory on the Ubuntu VM:
   $ cd ~
   $ cp -r xv6-public xv6-public-backup

2) Create a temporary directory and copy files from the archive there:
   $ mkdir -p /tmp/xv6proj_mod
   (then copy the files from this archive into /tmp/xv6proj_mod on the VM)

3) Run the helper script (it will backup originals and copy files):
   $ cd /tmp/xv6proj_mod
   $ sudo bash apply_patches.sh

4) Build:
   $ cd ~/xv6-public
   $ make clean
   $ make qemu

If you prefer manual steps, follow the detailed instructions in the README file inside this archive.

COPYING FILES FROM WINDOWS TO UBUNTU VM (quick tips)
1) If you use VMware Workstation/Player: enable Shared Folders in VM settings (map host folder to guest) and install open-vm-tools/open-vm-tools-desktop on Ubuntu:
   $ sudo apt-get update
   $ sudo apt-get install -y open-vm-tools open-vm-tools-desktop
   The shared folder is usually visible under /mnt/hgfs/<sharename>

2) If you have network between host and guest: enable SSH on the VM and use scp from Windows PowerShell:
   On Ubuntu VM: $ sudo apt-get install -y openssh-server
   From Windows PowerShell: scp C:\path\to\xv6_project_oneshot.zip user@<VM_IP>:/home/user/

3) Use WinSCP (GUI) to drag & drop files to the Ubuntu VM when SSH is enabled.
