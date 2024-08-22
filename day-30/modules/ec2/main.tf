resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name       = "harsh-key"

  tags = {
    Name = "${terraform.workspace}-webserver"
  }

  provisioner "remote-exec" {
    inline = [
    "sudo apt-get update -y",
    "sudo apt-get install -y apache2",
    "sudo systemctl start apache2",
    "sudo systemctl enable apache2"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo 'EC2 instance successfully provisioned with Apache.'"
  }
}
