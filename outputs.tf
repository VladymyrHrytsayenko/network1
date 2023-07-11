output "vpc_id" {
  value = aws_vpc.main.id
}


output "vpc_cidr" {
  value = aws_vpc.main.cidr_block

}

output "Public_ids" {
  value = aws_subnet.Public[*].id
}


output "Private_ids" {
  value = aws_subnet.Private[*].id
}
