variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-2"
}

variable "aws_cognito_identity_pool_id" {}
variable "aws_api_gateway_rest_api_id" {}
variable "aws_api_gateway_resource_parent" {}
variable "aws_api_gateway_resource_parent_path" {}
