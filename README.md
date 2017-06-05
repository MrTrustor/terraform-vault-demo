# terraform-vault-demo
The demonstration for my talk at the Hashicorp User Group Paris #2

## Demo Terraform

Export the right `AWS_DEFAULT_PROFILE` variable and simply run:

```bash
cd demo_tf
./run.sh
```

To clean everything:

```bash
./clean.sh
```

## Demo Vault

Simply run:

```bash
cd demo_vault
./run.sh
```

To clean everything:

```bash
./clean.sh
```

## Demo Vault AWS

Export the right `AWS_DEFAULT_PROFILE`. You have to replace the strings
`%ROOT_ACCOUNT_ID%` and `%TARGET_ACCOUNT_ID%` by their respective values in
the `demo_vault_aws` directory.

```bash
cd demo_vault_aws
./run.sh
```

To clean up everything, change the `AWS_DEFAULT_PROFILE` variables in the `clean.sh`
script and then run it.
