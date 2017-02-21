# terraform

Get Terraform from [terraform.io](https://www.terraform.io/).

To use this repo you will need to create a `terraform.tfvars` file
which contains your AWS Secret Key and AWS Access Key:

```
aws_access_key = "XXXXXXXXXXXXXX"
aws_secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```

After doing that, you can run `terraform apply` to build the
infrastructure.

