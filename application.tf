resource "aws_lb_target_group" "liorm-TF-easy-ALB-TG" {
  name     = "liorm-TF-easy-ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.liorm-TF-easy-vpc.id
}

resource "aws_lb_target_group_attachment" "liorm-tg-attach-1a" {
  target_group_arn = aws_lb_target_group.liorm-TF-easy-ALB-TG.arn
  target_id        = aws_instance.liorm-TF-easy-EC2-1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "liorm-tg-attach-1b" {
  target_group_arn = aws_lb_target_group.liorm-TF-easy-ALB-TG.arn
  target_id        = aws_instance.liorm-TF-easy-EC2-1b.id
  port             = 80
}

resource "aws_lb" "liorm-TF-ALB" {
  name               = "liorm-TF-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.liorm-TF-easy-SG.id]
  subnets            = [aws_subnet.liorm-TF-easy-us-east-1a.id, aws_subnet.liorm-TF-easy-us-east-1b.id]

  enable_deletion_protection = false

  tags = {
    Name = "liorm-TF-ALB"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.liorm-TF-ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.liorm-TF-easy-ALB-TG.arn
  }
}
