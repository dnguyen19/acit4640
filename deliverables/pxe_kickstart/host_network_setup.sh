vboxmanage () { VBoxManage.exe "$@";}

declare vm_name="acit4640"
declare vm_folder="C:\Users\denis\Documents\CIT\CIT4\provision"

declare network_name="sys_net_prov"
declare network_address=""
declare cidr_bits="24"
declare local_ip="192.168.254.10"
declare pxe_ip="192.168.254.5"
 
declare port_num=0
declare devic_num=0
declare ios_file_path="C:\Users\denis\Documents\CIT\CIT4\provision\CentOS-7-x86_64-Minimal-1810.iso"

vboxmanage natnetwork add --netname ${network_name} --network "${network_address}/${cidr_bits}" --dhcp off

vboxmanage natnetwork modify --netname ${network_name} --port-forward-4 "rule_1:TCP:[${network_address}]:50022:[${local_ip}]:22"
	
vboxmanage natnetwork modify --netname ${network_name} --port-forward-4 "rule_2:TCP:[${network_address}]:50080:[${local_ip}]:80"
	
vboxmanage natnetwork modify --netname ${network_name} --port-forward-4 "rule_3:TCP:[${network_address}]:50443:[${local_ip}]:443"

vboxmanage natnetwork modify --netname ${network_name} --port-forward-4 "Rule 4:TCP:[${network_address}]:50222:[${pxe_ip}]:22"
