resource "aws_instance" "instance" {
  ami                         = "ami-0f310fced6141e627"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group]
  subnet_id                   = var.subnet_id
  iam_instance_profile        = aws_iam_instance_profile.systems_manager.name
  associate_public_ip_address = "true"

  // TODO
  // ファイルの存在確認によって処理分岐
  user_data = file("./script.sh")

  tags = {
    Name = var.name
  }
}

resource "aws_iam_instance_profile" "systems_manager" {
  name = "Profile"
  role = var.iam_role
}