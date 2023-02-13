resource "aws_security_group" "front" {
  name        = "${var.customer}-${var.project}-front-${var.env}"
  description = "Front ${var.env} for ${var.project}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "cycloid.io" = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
}

resource "aws_instance" "front" {
  ami                         = data.aws_ami.debian.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.front.id]

  user_data_base64 = base64encode(templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      git_code_commit = var.git_code_commit
      git_code_repo   = var.git_code_repo
      env             = var.env
      project         = var.project
    }
  ))

  tags = {
    Name         = "${var.customer}-${var.project}-front-${var.env}"
    "cycloid.io" = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
}
