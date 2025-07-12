
terraform {
backend "s3" {
region = "us-east-1"
bucket = "shaikmustafa77.flm.devsecops.project.bucket"
key = "prod/terraform.tfstate"
}
}
