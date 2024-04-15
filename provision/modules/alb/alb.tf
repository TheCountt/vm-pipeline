# ----------------------------
#External Load balancer for reverse proxy nginx
#---------------------------------

resource "aws_lb" "ext-alb" {
  name            = "ext-alb"
  internal        = false
  security_groups = [var.public-sg]
  subnets = var.public_subnet_ids
  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
  # access_logs {
  #   bucket  = aws_s3_bucket.alb_access_logs.id
  #   prefix  = "access-log"
  #   enabled = true
  # }
  tags = merge(
    var.tags,
    {
      Name = "ACS-ext-alb"
    }
  )
}

#--- create a target group for the external load balancer
resource "aws_lb_target_group" "nginx-tgt" {
  name        = var.nginx_target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

#--- create a listener for the load balancer

resource "aws_lb_listener" "nginx-listener" {
  load_balancer_arn = aws_lb.ext-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}



# ----------------------------
#Internal Load Balancers for webservers
#---------------------------------

resource "aws_lb" "ialb" {
  name     = "ialb"
  internal = true
  security_groups = [var.private-sg]
  subnets = var.private_subnet_ids
  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
  tags = merge(
    var.tags,
    {
      Name = "ACS-int-alb"
    },
  )
}


resource "aws_lb_target_group" "sso-tgt" {
  name     = "sso"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  }


resource "aws_lb_listener" "sso-listener" {
  load_balancer_arn = aws_lb.ialb.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sso-tgt.arn
  }
}




# resource "aws_lb_target_group" "web_app_tgt" {
#   count             = length(var.web_apps)
#   name              = var.web_apps[count.index].name
#   port              = var.web_apps[count.index].port
#   protocol          = "HTTP"
#   vpc_id            = var.vpc_id
#   target_type       = "instance"
#   tags  = merge(
#     var.tags,
#     {
#     Name = var.web_apps[count.index].name
#   })
# }

# resource "aws_lb_listener" "alb_listener" {
#   load_balancer_arn = aws_lb.ialb.arn
#   port              = 80
#   protocol          = "HTTP"

#   dynamic "default_action" {
#     for_each = var.web_apps
#     content {
#       type = "forward"

#     }
#   }
# }


# resource "aws_lb_listener_rule" "alb_listener_rules" {
#   listener_arn = aws_lb_listener.alb_listener.arn

#   count = length(var.web_apps)

#   priority = count.index + 1

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_app_tgt[count.index].arn
#   }

#   condition {
#     host_header {
#       values = [var.web_apps[count.index].host]
#     }
#   }
# }




