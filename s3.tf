resource "aws_s3_bucket" "cm-terraform-000" {
  bucket = "ys-test-bucket-11"
  acl    = "private"
}
