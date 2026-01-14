# provider block
provider "aws" {
    # region
    region = "eu-west-1"
}

data "aws_caller_identity" "current" {}
 
output "aws_account_id" {
    value = data.aws_caller_identity.current.account_id
}
 
output "aws_user_arn" {
    value = data.aws_caller_identity.current.arn
}