data "vault_generic_secret" "secret" {
  path = "secret/terraform"
}

resource "aws_key_pair" "hug_demo" {
  key_name   = "hug_demo"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "hug_demo" {
  ami           = "ami-87848ee3"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.hug_demo.key_name}"

  vpc_security_group_ids = ["${aws_security_group.hug_demo.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "The secret is ${data.vault_generic_secret.secret.data["secret"]}!" > /home/admin/secret.txt
              EOF

  tags {
    Name = "HelloHUG"
  }
}

resource "aws_security_group" "hug_demo" {
  name        = "allow_all"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "connect" {
  value = "ssh admin@${aws_instance.hug_demo.public_dns}"
}
