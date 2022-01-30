output "vpc_id" {
  value = aws_vpc.eich-vpc.id
}


output "subnets_id" {
  value = aws_subnet.subnets[*].id
}