


#output "ec2_public_ip" {
 #   value = aws_instance.my-instance[*].public_ip
  
#}
#output "ec2_public_dns" {
 #   value = aws_instance.my-instance[*].public_dns
  
#}
#output "aws_private_ip" {
 # value = aws_instance.my-instance[*].private_ip
#}
#output "aws_vpc_id" {
 #   value = aws_default_vpc.default.id
 
#} 
output "ec2_public_ip" {

    value = [
        for instance in aws_instance.my-instance : instance.public_ip
    ]
}