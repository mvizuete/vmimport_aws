resource "aws_s3_bucket" "vmimport_bucket" {
  bucket = var.bucket_name
}
