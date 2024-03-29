# Credential Validation Exercise

The sole purpose of this Terraform configuration is to test your Intersight
API credentials.

## Setup Environment Variables

Outside of more production grade methods (e.g. Vault or Terraform Cloud),
the more reasonably safe method of specifying credentials is to define
environment variables in your shell that the Terraform binary will leverage
within the configuration.

If you've followed the instructions in the [parent README.md](../README.md)
to create your Intersight API credentials, you can simply leverage the
included [intersight-credentials.sh](./intersight-credentials.sh) script to
setup your environment:

```bash
export SECURE=DIR_WITH_MY_CREDENTIALS
source intersight-credentials.sh
```

Otherwise, feel free to manually specify the following two environment
variables:

- **TF_VAR_apikey**: API Key ID generated by Intersight
- **TF_VAR_secretkey**: Either the API secret filename or contents of file

## Instructions for successful exercise

The Terraform configuration will leverage your credentials and simply fetch
and output the MOID of the default organization.  Your commands to test your
setup are:

```bash
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

Aside from not seeing any errors (or Terraform actually creating any new state),
you can validate you received existing state for the default organization via:

```bash
$ terraform state list
data.intersight_organization_organization.default
```
