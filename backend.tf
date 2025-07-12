
terraform {
backend "s3" {
region = "us-west-1"
bucket = "shaikmustafa77.flm.devsecops.project.bucket"
key = "prod/terraform.tfstate"
}
}
