#####################################
## Virtual Machine Module - Output ##
#####################################

output "vm_linux_server_instance_public_ip" {
  value = aws_instance.linux-server[*].public_ip
}
