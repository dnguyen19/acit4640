vboxmanage createvm --name ${vm_name} --register

vboxmanage createhd --filename ${vm_folder}/${vm_name}.vdi \
					--size 1000 -variant Standard
					
vboxmanage storagectl ${vm_name} --name ide_storage --add ide --bootable on
vboxmanage storagectl ${vm_name} --name sata_storage --add sata --bootable on
					
					
vboxmanage storageattach ${vm_name} \
					--storagectl ${ctrlr_name} \
					--port ${port_num} \
					--device ${devic_num} \
					--type dvddrive \
					--medium ${ios_file_path}
					
vboxmanage storageattach ${vm_name} \
					--storagectl ${ctrlr_name} \
					--port ${port_num} \
					--device ${devic_num} \
					--type dvddrive \
					--medium "mnt/c/Program Files/Oracle/VirtualBox/VBoxGuestAdditions.iso"
					
vboxmanage storageattach ${vm_name} \
					--storagectl ${ctrlr_name} \
					--port ${port_num} \
					--device ${device_num} \
					--type hdd \
					--medium ${vm_folder}/${vm_name}.vdi \
					--nonrotational on
					
					
vboxmanage modifyvm WP_VM\
            --groups "${group_name}"\
            --ostype "RedHat_64"\
            --cpus 1\
            --hwvirtex on\
            --nestedpaging on\
            --largepages on\
            --firmware bios\
            --nic1 natnetwork\
            --nat-network1 "sys_net_prov"\
            --cableconnected1 on\
            --audio none\
            --boot1 disk\
            --boot2 dvd\
            --boot3 none\
            --boot4 none\
            --memory "1280"
			
vboxmanage startvm WP_VM --type gui