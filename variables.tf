variable "aws_instance_type" {
    default = "t3.micro"
    type = string
  
}
variable "aws_root_storage_size" {
    default = 10
    type = number
  
}
variable "ec2_ami_id" {
    default = "ami-019715e0d74f695be"
    type = string
  
}