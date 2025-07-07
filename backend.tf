terraform {
  backend "s3" {
    bucket         = "rxsense-terraform-state-bhargav"
    key            = "networking/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
