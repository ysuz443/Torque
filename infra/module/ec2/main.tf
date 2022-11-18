data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amzn2.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
  }
  tags = {
    Name = "${var.name_prefix}-ec2-${var.component}"
  }
}

resource "aws_security_group" "ec2" {
  description = "Allow access to the public facing EC2"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-ec2-${var.component}-sg"
  }
}

resource "aws_security_group_rule" "ec2_egress_any" {
  type              = "egress"
  description       = "to any"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "0.0.0.0/0"
  security_group_id = aws_security_group.ec2.id
}