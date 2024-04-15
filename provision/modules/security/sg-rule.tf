# SECURITY GROUP FOR ALB, TO ALLOW ACESS FROM ANY WHERE FOR HTTP(S) TRAFFIC
resource "aws_security_group_rule" "inbound-alb-http" {
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ACS["ext-alb-sg"].id
}

resource "aws_security_group_rule" "inbound-alb-https" {
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ACS["ext-alb-sg"].id
}

# SECURITY GROUP RULE FOR BASTION TO ALLOW SSH ACCESS FROM YOUR LOCAL MACHINE
resource "aws_security_group_rule" "inbound-ssh-bastion" {
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ACS["bastion-sg"].id
}

# SECURITY GROUP FOR NGINX REVERSE PROXY, TO ALLOW ACCESS ONLY FROM THE EXTERNAL LOAD BALANCER AND WORKSTATION

resource "aws_security_group_rule" "inbound-ext-alb-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["ext-alb-sg"].id
  security_group_id        = aws_security_group.ACS["nginx-sg"].id
}


resource "aws_security_group_rule" "inbound-ext-alb-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["ext-alb-sg"].id
  security_group_id        = aws_security_group.ACS["nginx-sg"].id
}

resource "aws_security_group_rule" "inbound-port-workstation-ssh" {
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ACS["nginx-sg"].id
}



# SECURITY GROUP FOR IALB, TO HAVE ACCES ONLY FROM NGINX REVERSE PROXY SERVER

resource "aws_security_group_rule" "inbound-ialb-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["nginx-sg"].id
  security_group_id        = aws_security_group.ACS["int-alb-sg"].id
}



resource "aws_security_group_rule" "inbound-ialb-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["nginx-sg"].id
  security_group_id        = aws_security_group.ACS["int-alb-sg"].id
}


# SECURITY GROUP FOR APP-SERVER, TO ALLOW ACCESS FROM THE NGINX REVERSE PROXY, INTERNAL LOAD BALANCER
# AND BASTION

resource "aws_security_group_rule" "inbound-nginx-https-to-app-server" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["nginx-sg"].id
  security_group_id        = aws_security_group.ACS["app-server-sg"].id
}

resource "aws_security_group_rule" "inbound-nginx-http-to-app-server" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["nginx-sg"].id
  security_group_id        = aws_security_group.ACS["app-server-sg"].id
}

resource "aws_security_group_rule" "inbound-nginx-service-ports-to-app-server" {
  type                     = "ingress"
  from_port                = 8050
  to_port                  = 8060
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["nginx-sg"].id
  security_group_id        = aws_security_group.ACS["app-server-sg"].id
}

resource "aws_security_group_rule" "inbound-internal-alb-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["int-alb-sg"].id
  security_group_id        = aws_security_group.ACS["app-server-sg"].id
}

resource "aws_security_group_rule" "inbound-internal-alb-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["int-alb-sg"].id
  security_group_id        = aws_security_group.ACS["app-server-sg"].id
}

resource "aws_security_group_rule" "inbound-internal-alb-service-ports-http" {
  type                     = "ingress"
  from_port                = 8050
  to_port                  = 8060
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["int-alb-sg"].id
  security_group_id        = aws_security_group.ACS["app-server-sg"].id
}

resource "aws_security_group_rule" "inbound-nginx-ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["nginx-sg"].id
  security_group_id        = aws_security_group.ACS["app-server-sg"].id
}

resource "aws_security_group_rule" "bastion-ssh" {
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  source_security_group_id = aws_security_group.ACS["bastion-sg"].id
  security_group_id = aws_security_group.ACS["app-server-sg"].id
}

resource "aws_security_group_rule" "inbound-workstation-ssh" {
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ACS["app-server-sg"].id
}

# SECURITY GROUP FOR DATALAYER TO ALLOW TRAFFIC TO/FROM APP-SERVER ON EFS(NFS). MYSQL,
# MONGODB, ELASTICACHE(REDIS), RABBITMQ
resource "aws_security_group_rule" "inbound-nfs-" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["app-server-sg"].id
  security_group_id        = aws_security_group.ACS["datalayer-sg"].id
}

resource "aws_security_group_rule" "inbound-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["app-server-sg"].id
  security_group_id        = aws_security_group.ACS["datalayer-sg"].id
}

resource "aws_security_group_rule" "public" {
  from_port         = 3306
  protocol          = "tcp"
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ACS["datalayer-sg"].id
}

resource "aws_security_group_rule" "inbound-mongodb" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["app-server-sg"].id
  security_group_id        = aws_security_group.ACS["datalayer-sg"].id
}

resource "aws_security_group_rule" "inbound-redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["app-server-sg"].id
  security_group_id        = aws_security_group.ACS["datalayer-sg"].id
}

resource "aws_security_group_rule" "inbound-rabbitmq" {
  type                     = "ingress"
  from_port                = 5671
  to_port                  = 5673
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["app-server-sg"].id
  security_group_id        = aws_security_group.ACS["datalayer-sg"].id
}