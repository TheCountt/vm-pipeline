output "alb-sg" {
  value = aws_security_group.ACS["ext-alb-sg"].id
}


output "ialb-sg" {
  value = aws_security_group.ACS["int-alb-sg"].id
}


output "nginx-sg" {
  value = aws_security_group.ACS["nginx-sg"].id
}



output "app-server-sg" {
  value = aws_security_group.ACS["app-server-sg"].id
}


output "datalayer-sg" {
  value = aws_security_group.ACS["datalayer-sg"].id
}

output "bastion-sg" {
  value = aws_security_group.ACS["bastion-sg"].id
}