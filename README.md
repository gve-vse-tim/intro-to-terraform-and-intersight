# intro-to-terraform-and-intersight

Example Terraform configuration files to build a server profile in Intersight

This code repository is tested based on Intersight as it was released on Thursday, 3 Dec 2020.
Keep in mind the platform is a SaaS platform that frequently rolls out bug fixes and features.
Please check the [Terraform provider for Intersight GitHub issues page](https://github.com/CiscoDevNet/terraform-provider-intersight/issues) for new or resolved issues that may affect the provider's
behavior.

## Repository layout

There is a Vagrantfile provided if you want a "clean" environment in which to
run Terraform. Instructions are provided at the bottom on how to consume it.

Otherwise, the entirety of the Terraform is in the [terraform](./terraform)
directory. The only setup required is setting up the authentication.

## Authentication setup

You'll need to create an API key and secret key file within Intersight for the
account into which you will be deploying these Terraform defined resources. You
can [generate those credentials here.](https://intersight.com/an/settings/api-keys/)

Save the secret key file in the terraform subdirectory as **Intersight-API-Secret.pem**.

Edit the [credentials.tf](terraform/credentials.tf) file and make the following two changes:

- Change the **default** argument in the *apikey* variable to the value of the Intersight account's API key
- Change the **default** argument in the *secretkefile* variable to the filename which contains the secret key

## Vagrant Developer Environment Included

If you don't have Terraform on your laptop/desktop/cloud, you can simply use
the provided Vagrantfile to spin up a VM in VirtualBox, log into that VM, and
run the terraform commands there.  The process looks like:

- Install Vagrant via [direct download](https://www.vagrantup.com/downloads.html) or via [Home Brew](https://formulae.brew.sh/cask/vagrant)
- Install VirtualBox via [direct download](https://www.virtualbox.org/wiki/Downloads) or via [Home Brew](https://formulae.brew.sh/cask/virtualbox)
- Run the following commands:

```bash
(laptop)$ vagrant up
# Let the environment provision (could take several minutes)
(laptop)$ vagrant ssh
# Now you are logged into the VM
(VM)$ cd terraform
(VM)$ terraform init
(VM)$ terraform plan
(VM)$ terraform apply
```

The Git repository directory **terraform** is mounted inside the VM (the reason for the
*cd terraform* above) and all of its files are shared between the host laptop and the
guest VM.

Note: the above instructions assume you have set up the authentication required for Intersight
as instructed above.

If you require proxy settings to connect to the Internet, you'll have to run **vagrant up** with
the **--no-provision** argument, log into the VM, and manually set the proxy values in order to
the manually run the provisioning steps in the Vagrantfile.
