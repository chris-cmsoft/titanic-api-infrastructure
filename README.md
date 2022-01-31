# Titanic API Infrastructure

## Purpose

The purpose of this repository is for training the next generation of Cloud Native experts. 

It accompanies the [titanic-api](https://github.com/chris-cmsoft/titanic-api) repository where the codebase for the actual API lives.

This infrastructure deploys on DigitalOcean for simplicity.

## Authentication

In order to create the infrastructure, you'll need a Personal Access Token from DigitalOcean.

Put that in a file called `local.auto.tfvars`, which will automatically get injected when creating the infrastructure.

```hcl-terraform
digital_ocean_token=XXX
```

## Installation

To create the infrastructure necessary

```bash
terraform int
terraform apply 
```