# Key Pair
resource "aws_key_pair" "rsa-aws-key" {
 key_name = var.key_name
 public_key = file("${path.module}/${var.key_name}.pub")
}

# security Group

resource "aws_security_group" "ec2_sg" {
  name = "ec2-security-group"
  description = "Allow HTTP and SSH"
  vpc_id = data.aws_vpc.default.id

  ingress  {
    description = "HTTP"
    from_port = 80
    to_port     =80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //all
  }
  
  ingress {
    description = "SSH"
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "all internet"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}

#get default VPC

data "aws_vpc" "default"{
    default = true
}

# default subnet

# data "aws_subnet" "default" {
#   default_for_az = true
#   availability_zone = "ap-south-1"
# }

#get latest amazon linux ami
# data "aws_ami" "amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }


# EC2 instance

resource "aws_instance" "my_ec2" {
    ami = "ami-0fad8318b9405c6fb"
    instance_type = var.instance_type
    key_name = aws_key_pair.rsa-aws-key.key_name
    subnet_id = "subnet-0dbb6f52afc0f95ae"
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]


    tags = {
        Name = "Terraform-EC2"
    }
  #install nginx

    provisioner "remote-exec"{
        inline =[
            "sudo yum update -y",
            "sudo amazon-linux-extras install nginx1 -y",
            "sudo systemctl start nginx",
            "sudo systemctl enable nginx"
        ]

        connection{
            type = "ssh"
            user = "ec2-user"
            private_key = file("${path.module}/${var.key_name}")
            host = self.public_ip
        }
    }
}




