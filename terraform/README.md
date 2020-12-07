# Server Profile Example for Terrafor Intersight Provider

This example is take directly from a valid, server deployment to an
internal Cisco lab C240 M4L server.  That being said, it is derived heavily
on information taken from the following sources:

- [Terraform Registry Intersight Provider documentation](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs)
- [Terrafor Provider for Intersight GitHb docs/examples](https://github.com/CiscoDevNet/terraform-provider-intersight)
- [Intersight API Reference](https://intersight.com/apidocs/apirefs/)

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
