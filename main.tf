##Create an instance
# resource "aws_instance" "first_instance" {
#   ami = "ami-007855ac798b5175e"
#   instance_type ="t2.micro"
#   key_name= "terraform"

#   tags = {
#     Name ="instance1"
#     Created_By ="terraform"
#   }
# }

# resource "aws_security_group" "cluster" {
#   #name_prefix = "cluster-"
#   name ="my-cluster"
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_instance" "node" {
  count = 1
  ami   = "ami-007855ac798b5175e"
  #ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "terraform2"
  # security_groups = [ "sg-0f9e9b7a75dd5ae71"
  #   #aws_security_group.cluster.id
  # ]

  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   private_key = file("/home/masoud/Downloads/terraform2.pem")
  #   host        = self.public_ip
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get update",
  #     "sudo apt-get install -y apache2",
  #     "sudo systemctl start apache2",
  #     "sudo systemctl enable apache2"
  #   ]
  # }
}
# resource "aws_instance" "second_instance" {
#   ami = "ami-007855ac798b5175e"
#   instance_type ="t2.micro"
#   key_name= "terraform"

#   tags = {
#     Name ="instance2"
#     Created_By ="terraform"
#   }
# }
# resource "null_resource" "instance_ping" {
#   for_each = {for ip in output.ip : ip => ip}
#   provisioner "local-exec" {
#     command= "echo ip >>ip.txt"
#   }
# }

resource "local_file" "vm_ip" {
  content  = join("\n", aws_instance.node.*.public_ip)
  filename = "vm_ip.txt"
}