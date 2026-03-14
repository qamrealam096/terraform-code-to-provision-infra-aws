# key pair 
resource "aws_key_pair" "my-key" {

    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
  
}

# vpc & secutity group chahiye
resource "aws_default_vpc" "default" {


  
}
resource "aws_security_group" "my_security_group" {
    name = "automate-sg"
    description = "this will add tf generated security group"
    vpc_id = aws_default_vpc.default.id #interpolation

    #inbound rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }
    ingress {
         from_port = 80
         to_port =  80
         protocol = "tcp"
         cidr_blocks = [ "0.0.0.0/0" ]
         description = "http open"

    }

    #outbound rules5
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "all port open"
    }
    tags = {
      Name = "automate-sg"
    }
  
}


# ec2 instance
resource "aws_instance" "my-instance" {
    for_each = tomap ({
        "alam-instace-t3" = "t3.micro"
        "alam-instance-2" = "t3.micro"

    }) # meta argument
    ami = var.ec2_ami_id
    key_name = aws_key_pair.my-key.key_name
    security_groups = [ aws_security_group.my_security_group.name ]
    instance_type = each.value
    user_data = file ("install-nginx.sh")

    root_block_device {
      volume_size = var.aws_root_storage_size
      volume_type = "gp3"
    }
    tags = {
      Name = each.key
      }
    
  
}
