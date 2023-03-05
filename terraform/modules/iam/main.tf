data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = var.type
      identifiers = var.identifier_list
    }
  }
}

resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "default" {
  for_each   = toset(var.managed_policy_list)
  role       = aws_iam_role.role.name
  policy_arn = each.value
}

resource "aws_iam_role_policy" "kms_decrypt_policy" {
  for_each = { for i in var.custom_policy_list : i.name => i }
  name   = each.value.name
  role   = aws_iam_role.role.id  
  policy = each.value.policy
}
