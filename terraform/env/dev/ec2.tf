module "ec2_bastion" {
  source = "../../modules/ec2"

  name           = "${var.prefix}-${var.system}-bastionRDS-ec2"
  security_group = module.api_ec2_service_sg.security_group_id
  subnet_id      = module.vpc.public_subnets[0]
  iam_role       = module.iam_ec2.role_name
  instance_type = "t2.medium"

  key_name = "sample-kuchiki-openid"
}