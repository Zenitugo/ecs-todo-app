resource "aws_instance" "todo_app_server" {
    ami                             = data.aws_ami.ubuntu.id
    instance_type                   = var.instance_type
    key_name                        = var.key_name
    subnet_id                       = var.public_subnet_id
    vpc_security_group_ids          = var.sg_ids

    tags = {
        Name = "${var.name}-ec2"
    }
     
}


# Create a key pair
resource "aws_key_pair" "ec2_key" {
  key_name = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Create a Private key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Put the private key in a local file
resource "local_file" "testkey_private" {
  content = tls_private_key.ssh_key.private_key_pem
  filename = var.key_filename
}