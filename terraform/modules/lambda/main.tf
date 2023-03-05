// docker image前提
resource "aws_lambda_function" "lambda_function" {
  function_name = var.name
  role = var.role
  package_type = "Image"
  image_uri = var.image_uri
  environment {
    variables = var.env_variables
  }
  lifecycle {
    ignore_changes = [image_uri]
  }
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
  image_config {
    entry_point = var.entry_point
  }

}