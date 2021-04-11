#***************************************************************************************#
#											#
#	Use Case - hosting a TCP Echo server within docker container using Ansible	#									
#	Author: BASKAR BALASUBRAMANIAN BITS ID: 2019HT66015@wilp.bits-pilani.ac.in	#
#											#
#***************************************************************************************#
> ./hosts

echo "***************************************************************************"
echo "Use Case - hosting a TCP Echo server within docker container using Ansible."
echo "***************************************************************************"
sleep 3

#start the virtual machine from the pre-built image
echo "*****************************************************"
echo "Starting the virtual machine from the pre-built image"
sleep 1
echo "Hosted Virtualization driver - qemu-kvm" 
sleep 1
echo "VM OS - RHEL 7"
sleep 2
echo "*****************************************************"

if [ `my_ansible_virt_rhel status | grep status | awk -F"\"status\": " '{print $2}' | sed -e "s/\"//g"` != "running" ]
then
	my_ansible_virt_rhel start

	echo "Wait for about a minute until vm starts "
	sleep 60
	echo "RHEL 7 VM started"
fi


#echo "provide the IP address of the vm"
#read IP_rhel

# Add the IP address to hosts file

#IP_rhel=`ansible 127.0.0.1 -m virt_net -a "command=facts" | grep ipaddr | tail -1 | awk -F": " '{print $2}'  | cut -d"," -f1 | sed -e "s/\"//g"`

echo "Provide the ip address of rhel VM you would like to proceed using the below list"

ansible-playbook job_vm_net.yml | egrep 'hostname|ipaddr'

echo "IP Address:"

read IP_rhel

echo "IP4 Address of the RHEL VM is $IP_rhel"
echo 
echo

sleep 1

echo "[rhel_vm_host]" >> ./hosts
echo $IP_rhel >> ./hosts 

sudo chown baskar:baskar ./hosts

#start sshd.service on the vm
#echo "Starting sshd.service on $IP_rhel. Provide SSH password for authentication"
#ansible-playbook -i ./hosts job_system_services_control.yml -e "service_name=sshd.service systemctl_arg1=stop" --ask-pass  -v

#check ansible ping pong with the rhel_vm
echo "*****************************************************"
echo "ping_pong check for RHEL VM"
echo "*****************************************************"

echo "pinging the $IP_rhel rhel vm. please provide your password for SSH login"

ansible -i ./hosts ${IP_rhel} -m ping -v --ask-pass


#install docker on rhel_kvm
echo "******************************************************"
echo    " Install docker image hosting a TCP Echo server"
echo "******************************************************"

echo "Installing docker on the rhel vm  ${IP_rhel}. Provide your password for SSH login"
sleep 2

ansible -i ./hosts ${IP_rhel} -m yum -a "name=docker state=latest" --ask-pass --become --become-method=sudo -K

#start docker.service on the vm

echo "Starting docker.service on $IP_rhel. Provide SSH password for authentication"
sleep 2

ansible-playbook -i ./hosts job_system_services_control.yml  --ask-pass   --become --become-method=sudo -K

#copy the docker files to the rhel VM

echo "Copying the docker files for TCP server to rhel vm. Provide SSH password for authentication"
sleep 2

ansible -i ./hosts rhel_vm_host -m copy -a "src=/home/baskar/ansible/TCP dest=/home/baskar/ansible/ mode=754" --ask-pass

#build centos docker image & tcpserver docker image and tart the tcpserver container
echo "Cleaning existing docker containers and images"

ansible-playbook -i ./hosts job_docker_operations.yml -e "build_arg=destroy" --ask-pass -K

echo "Performing docker operations to pull 'centos' container image, build 'tcpserver' container image and run 'tcpserver_1' contianer'. Provide SSH password for authentication"
sleep 5

ansible-playbook -i ./hosts job_docker_operations.yml --ask-pass -K 


echo "*************************************************************************"
echo "Use Case completed for hosting a TCP Echo server within docker container."
echo "TCP Echo server is ready to listen on port 4305"
echo "Use echocli (TCP Echo client) to communicate with TCP Echo server."
echo "*************************************************************************"

# Install, configure and start Prometheus and node_exporter for data collection

echo "Installing prometheus and node_exporter for collecting TCP data."

ansible-playbook -i ./hosts job_prometheus_install_configure_start.yml --ask-pass -K

sleep 5

echo "Installation of prometheus and node_exporter for collecting TCP data completed."

# Install, configure and start grafana for visualization of the collected data

echo "Installing grafana for visualizing TCP data."

ansible-playbook -i ./hosts job_grafana_install_configure_start.yml --ask-pass -K

sleep 5

echo "Installation of grafana for visualizing TCP data completed."

