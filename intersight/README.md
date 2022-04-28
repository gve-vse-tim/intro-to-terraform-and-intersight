# UCS Intersight Managed Server Profile Example

This example is take directly from a valid, server deployment to an
internal Cisco lab C220 M5S server, connected to Fabric Interconnects
running in Intersight Managed Mode. The Terraform plan is developed
using the following reference information:

- [Terraform Registry Intersight Provider documentation](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs)
- [Terrafor Provider for Intersight GitHb docs/examples](https://github.com/CiscoDevNet/terraform-provider-intersight)
- [Intersight API Reference](https://intersight.com/apidocs/apirefs/)

## Background Information

The Intersight provider is built directly from the OpenAPI-based Intersight
REST API and its representation of the underlying data models. At the time of
this writing, the Intersight provider does not provide high level resources
such as a single resource representing a network interface or network adapter.

From my experience, at this point in time, I recommend approaching the provider
as an easier to consume interface for the direct REST API calls. Or, put another
way, it's a simplified means (using Terraform Hashicorp Language) to make REST
API calls without the need to write a lot of Python REST overhead.

It is under **active, rapid** development so please provide feedback via the
[GitHub Issues](https://github.com/CiscoDevNet/terraform-provider-intersight/issues)
page for the engineering team to have visibility with provider usage issue.  Also,
reference that page to investigate possible reasons for behaviors in this example
repo differing from documented.

## Intersight Model

Since the provider essentially maps directly to the exact model representation present
in the REST API, it's essential to understand the model at least with respect to the
server profile.

## Authentication setup

You'll need to create an API key and secret key file within Intersight for the
account into which you will be deploying these Terraform defined resources. You
can [generate those credentials here.](https://intersight.com/an/settings/api-keys/)

For production scenarios, I recommend setting environment variables with the specific
credential information or leverage Terraform Cloud for the best credential security.

For basic local laptop demos, use the following instructions:

Save the secret key file in this directory as **Intersight-API-Secret.pem**. Edit the
[credentials.tf](./credentials.tf) file and make the following two changes:

- Change the **default** argument in the *apikey* variable to the value of the Intersight account's API key
- Change the **default** argument in the *secretkefile* variable to the filename which contains the secret key

## Creating the Server Profile

Standard Terraform operations apply at this point:

- terraform init
- terraform plan
- terraform apply
