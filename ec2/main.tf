data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ubuntu_filter]
  }
  owners = [ var.ubuntu_owner ]
}

resource "aws_instance" "public_ec2" {
  count = length(var.pub_subnets)
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.pub_subnets[count.index]
  vpc_security_group_ids = [var.allow_http_ssh]
  key_name = var.key_name
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.ubuntu_user
      private_key = file("./${var.key_name}.pem")
      host        = self.public_ip
    }
    script = "./${var.nginx_proxy}"
  }
}

resource "aws_instance" "private_ec2" {
  count = length(var.priv_subnets)
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.priv_subnets[count.index]
  vpc_security_group_ids = [var.allow_http_ssh]
  key_name = var.key_name
  user_data = var.apache2
}