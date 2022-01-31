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

The Kubernetes cluster can take about 10 minutes to spin up. 

This is quite normal considering what actually needs to happen for a Kubernetes cluster to start up and function correctly.

## Connecting to the Kubernetes cluster

In order to connect to the Kubernetes cluster, you need a local Kubernetes config.

You can get this either by going to the DigitalOcean UI and downloading the kubeconfig, 
or by using doctl 

```bash
doctl kubernetes cluster list
ID                                      Name           Region    Version        Auto Upgrade    Status     Node Pools
2b789472-36ba-4b2e-a8d0-e03c970a1ab0    titanic-api    fra1      1.21.9-do.0    true            running    default

# Copy the ID of the correct Kubernetes cluster
doctl kubernetes cluster kubeconfig save XXX # Replace XXX with cluster ID copied above
```

You should now be able to connect to kubernetes

```bash
kubectl get nodes
NAME            STATUS   ROLES    AGE     VERSION
default-ukmhn   Ready    <none>   5m22s   v1.21.9
```
