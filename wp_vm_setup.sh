vboxmanage () { VBoxManage.exe "$@";}


vboxmanage createvm --name WP_VM --register

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