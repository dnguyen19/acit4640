vboxmanage () { VBoxManage.exe "$@";}

declare ctrlr_type_1='ide'
declare ctrlr_type_2='sata'
declare vm_name="acit4640"
declare port_num=0
declare devic_num=0
declare network_name="sys_net_prov"
declare vm_folder="C:\Users\denis\Documents\CIT\CIT4\provision"
declare ios_file_path="C:\Users\denis\Documents\CIT\CIT4\provision\CentOS-7-x86_64-Minimal-1810.iso"

vboxmanage createvm --name ${vm_name} --register

vboxmanage createhd --filename ${vm_folder}//${vm_name}.vdi --size 8096 -variant Standard
					
vboxmanage storagectl ${vm_name} --name 'ide_controller' --add ${ctrlr_type_1} --bootable on
vboxmanage storagectl ${vm_name} --name 'sata_controller' --add ${ctrlr_type_2} --bootable on
										
vboxmanage storageattach ${vm_name} \
					--storagectl 'ide_controller' \
					--port ${port_num} \
					--device ${devic_num} \
					--type dvddrive \
					--medium ${ios_file_path}
					
vboxmanage storageattach ${vm_name} \
					--storagectl 'ide_controller' \
					--port ${port_num} \
					--device ${devic_num} \
					--type dvddrive \
					--medium ${vm_folder}\\${vm_name}.vdi
					
vboxmanage storageattach ${vm_name} \
					--storagectl 'sata_controller' \
					--port $port_num \
					--device $devic_num \
					--type hdd \
					--medium ${vm_folder}//${vm_name}.vdi \
					--nonrotational on
					
					
vboxmanage modifyvm ${vm_name}\
            --ostype "RedHat_64"\
            --cpus 1\
            --hwvirtex on\
            --nestedpaging on\
            --largepages on\
            --firmware bios\
            --nic1 natnetwork\
            --nat-network1 "${network_name}"\
            --cableconnected1 on\
            --audio none\
            --boot1 disk\
            --boot2 dvd\
            --boot3 none\
            --boot4 none\
            --memory 1280
			
#vboxmanage startvm ${vm_name} --type gui