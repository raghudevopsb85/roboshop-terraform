resource "aws_instance" "instance" {
  count                  = var.spot ? 0 : 1
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
  iam_instance_profile   = aws_iam_instance_profile.main.name

  root_block_device {
    volume_size = var.disk_size
  }

  tags = {
    Name = local.tagName
    monitor = var.monitor
  }
}

resource "aws_instance" "spot_instance" {
  count                  = var.spot ? 1 : 0
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
  iam_instance_profile   = aws_iam_instance_profile.main.name

  root_block_device {
    volume_size = var.disk_size
  }

  instance_market_options {
    market_type = "spot"
  }

  tags = {
    Name = local.tagName
  }
}

resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = local.dnsName
  type    = "A"
  ttl     = 30
  records = var.spot ? [aws_instance.spot_instance[0].private_ip] : [aws_instance.instance[0].private_ip]
}

resource "aws_route53_record" "public" {
  count   = var.env == null ? 1 : 0
  zone_id = var.zone_id
  name    = local.dnsNamePublic
  type    = "A"
  ttl     = 30
  records = var.spot ? [aws_instance.spot_instance[0].public_ip] : [aws_instance.instance[0].public_ip]
}

resource "null_resource" "ansible" {

  count = var.env == null ? 0 : 1

  triggers = {
    instance_id = var.spot ? aws_instance.spot_instance[0].id : aws_instance.instance[0].id
  }

  depends_on = [aws_route53_record.record]
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = data.vault_generic_secret.ssh-creds.data["username"]
      password = data.vault_generic_secret.ssh-creds.data["password"]
      host     = var.spot ? aws_instance.spot_instance[0].private_ip : aws_instance.instance[0].private_ip
    }

    inline = [
      "ansible-pull -i localhost, -U https://github.com/raghudevopsb85/roboshop-ansible roboshop.yml -e role_name=${var.name} -e token=${var.token} -e env=${var.env} | sudo tee /opt/ansible.log"
    ]
  }
}
