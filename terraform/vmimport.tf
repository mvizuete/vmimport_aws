
resource "aws_iam_role" "vmimport" {
  name               = "role_vmimport"
  assume_role_policy = file("./json/trust-policy.json")
}

resource "random_string" "sufijo" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

module "mybucket" {
  source      = "./modules/s3"
  bucket_name = "vmimport-${random_string.sufijo.id}"
}

output "s3_arn" {
  value = module.mybucket.S3_bucket_arn
}

data "template_file" "role_policy" {
  template = file("./json/role-policy.json")
  vars = {
    bucket_arn = module.mybucket.S3_bucket_arn
  }
}

resource "aws_iam_role_policy" "vmimport_policy" {
  name   = "vmimport"
  role   = aws_iam_role.vmimport.id
  policy = data.template_file.role_policy.rendered
}
