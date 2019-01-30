vboxmanage () { VBoxManage.exe "$@";}

declare vm_name="test"

declare vm_info="$(vboxmanage showvminfo "${vm_name}")"
declare vm_conf_line="$(echo "${vm_info}" | grep "Config file")"
declare vm_conf_file="$( echo "${vm_conf_line}" | grep -oE '(/[^/]+)+')"
declare vm_directory="$(dirname "${vm_conf_file}")"

echo "${vm_directory}"

declare network_name="sys_net_prov"
declare network_address="192.168.254.0"
declare cidr_bits="24"
declare local_ip="192.168.254.10"


echo "Network name: ${network_name}"
echo "Network Address: ${network_address}/${cidr_bits}"
echo "Local IP: ${local_ip}"



vboxmanage natnetwork add 
	--netname "sys_net_prov" 
	--network "192.168.254.0/24" 
	--dhcp off
	
vboxmanage natnetwork modify 
	--netname "sys_net_prov"
	--port-forward-4 "rule_1:TCP:[192.168.254.10]:50022:[192.168.254.10]:22"
	
vboxmanage natnetwork modify 
	--netname "sys_net_prov"
	--port-forward-4 "rule_2:TCP:[192.168.254.10]:50080:[192.168.254.10]:80"
	
vboxmanage natnetwork modify 
	--netname "sys_net_prov"
	--port-forward-4 "rule_3:TCP:[192.168.254.10]:50443:[192.168.254.10]:443"
	
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
					

					
	
	
	