#####################################
## Virtual Machine Module - Output ##
#####################################

# output "vm_linux_server_instance_public_ips" {
#   value = { 
#     for key, instance in aws_instance.linux-server : key => instance.public_ip 
#   }
# }

output "vm_linux_server_instance_eip" {
  value = {
    for key, eip in aws_eip.lb : key => eip.public_ip
  }
}
