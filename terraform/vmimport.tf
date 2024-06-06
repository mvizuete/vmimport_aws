
resource "aws_iam_role" "vmimport" {
  name               = "vmimport"
  assume_role_policy = file("./json/trust-policy.json")
}
