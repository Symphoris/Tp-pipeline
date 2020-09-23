data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}
# creating   aws instace

resource "aws_instance" "hello-terra" {
	ami = data.aws_ami.ubuntu.id
	instance_type = "t2.nano"
  security_groups = ["${aws_security_group.hello-terra-ssh.name}"]
	key_name = "Tp-aws"
	user_data = "${file("install_apache.sh")}"
	tags = {
		Name = "Terraform-Pipeline"	
		Batch = "5AM"
	}
}

data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_security_group" "hello-terra-ssh" {
  name        = "hello-terra-ssh"
  description = "Allow ssh and http traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
     ingress{
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}