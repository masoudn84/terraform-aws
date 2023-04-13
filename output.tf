output "test" {
  value = data.aws_ami.ubuntu.id
}
output "ips" {
value= [for instance in aws_instance.node: instance.public_ip]
}
output "ip" {
  value=aws_instance.node[*].public_ip
}