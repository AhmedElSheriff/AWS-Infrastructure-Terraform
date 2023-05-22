resource "aws_lb" "loadbalancers" {
    count              = 2
    name               = var.lb_names[count.index]
    internal           = count.index == 0 ? false : true
    load_balancer_type = "application"
    subnets            = count.index == 0 ? var.pub_subnets : var.priv_subnets
    security_groups    = [var.http_ssh_sg]
}

resource "aws_lb_listener" "listeners" {
    count = 2
    load_balancer_arn = aws_lb.loadbalancers[count.index].arn
    port              = var.listen_port
    protocol          = var.listen_protocol

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.targetgroups[count.index].arn
    }
}

resource "aws_lb_target_group" "targetgroups" {
    count       = 2
    name        = var.tg_names[count.index]
    port        = var.listen_port
    protocol    = var.listen_protocol
    vpc_id      = var.vpc_id
    target_type = "instance"

    health_check {
        path = "/"
    }
}

resource "aws_lb_target_group_attachment" "pub_tg_attachment" {
    count = length(var.public_instances)
    target_group_arn = aws_lb_target_group.targetgroups[0].arn
    target_id        = var.public_instances[count.index]
    port             = 80
}

resource "aws_lb_target_group_attachment" "priv_tg_attachment" {
    count = length(var.private_instances)
    target_group_arn = aws_lb_target_group.targetgroups[1].arn
    target_id        = var.private_instances[count.index]
    port             = 80
}