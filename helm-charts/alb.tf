resource "aws_security_group" "public_lb" {
  name        = "public_lb"
  description = "public_lb"
  vpc_id      = data.aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_lb"
  }
}

resource "aws_lb" "main" {
  name               = "public"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_lb.id]
  subnets            = data.aws_subnets.public-subnets.ids

  enable_deletion_protection = false

  tags = {
    Environment = "public"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "public-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
  target_type = "ip"
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  count            = length(var.internal_lb_ips)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.internal_lb_ips[count.index]
  port             = 80
}




