provider "vault" {}

data "vault_generic_secret" "aws_auth" {
  path = "aws/sts/hug"
}

provider "aws" {
  access_key = "${data.vault_generic_secret.aws_auth.data["access_key"]}"
  secret_key = "${data.vault_generic_secret.aws_auth.data["secret_key"]}"
  token      = "${data.vault_generic_secret.aws_auth.data["security_token"]}"
  region     = "eu-west-2"
}
