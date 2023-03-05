module "s3_image" {
  source = "../../modules/storage"

  name = "${var.prefix}-${var.system}-image-s3"
  acl  = "private"
}
