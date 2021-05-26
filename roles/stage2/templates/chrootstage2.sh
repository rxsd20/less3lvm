#!/bin/bash

chroot /mnt/ grub2-mkconfig -o /boot/grub2/grub.cfg
cd /boot; for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g; s/.img//g"` --force; done
mount /dev/vg_var/lv_var /mnt/
rsync -avHPSAX /var/ /mnt/
mkdir /tmp/oldvar && mv /var/* /tmp/oldvar
umount /mnt/
mount /dev/vg_var/lv_var /var/
echo "`blkid | grep var: | awk '{print $2}'` /var ext4 defaults 0 0" >> /etc/fstab
exit
