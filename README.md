# intro-to-terraform-and-intersight

Example Terraform configuration files to build a server profile in Intersight
for both UCS C-series rack mount servers operating in standalone mode and
for any UCS server attached to UCS Fabric Interconnects operating in
Intersight Managed Mode.

This code repository is tested based on Intersight as it was released on
Tuesday, April 26 2022. Keep in mind the platform is a SaaS platform that
frequently rolls out bug fixes and features. Please check the
[Terraform provider for Intersight GitHub issues page](https://github.com/CiscoDevNet/terraform-provider-intersight/issues)
for new or resolved issues that may affect the provider's behavior.

## Repository layout

There is a Vagrantfile provided if you want a "clean" environment in which to
run Terraform. Instructions are provided at the bottom on how to consume it.

There are two subdirectories, each of which contain self contained Terraform
HCL (Hashicorp Configuration Language) that defines the resources required
for a server profile. The only required setup involves Intersight
authentication.

- [UCS Standalone Server Profile](./standalone)
- [UCS Intersight Managed Server Profile](./intersight)

Details of setup and operation of each style is documented in their respective
README.md files.

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
# Set up Intersight authentication
(VM)$ cd standalone
(VM)$ terraform init
(VM)$ terraform plan
(VM)$ terraform apply
(VM)$ cd ../intersight
(VM)$ terraform init
(VM)$ terraform plan
(VM)$ terraform apply
```

The Git repository directories **standalone** and **intersight** are mounted
inside the VM (the reason for the *cd standalone* above) and all of its files
are shared between the host laptop and the guest VM.

Note: the above instructions assume you have set up the authentication required for Intersight
as instructed above.

If you require proxy settings to connect to the Internet, you'll have to run **vagrant up** with
the **--no-provision** argument, log into the VM, and manually set the proxy values in order to
the manually run the provisioning steps in the Vagrantfile.
