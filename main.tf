terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.11"
    }
  }
}

variable "digitalocean_token" {
  type = string
}

variable "digitalocean_region" {
  type = string
  default = "fra1"
}

provider "digitalocean" {
  token = var.digitalocean_token
}

data "digitalocean_kubernetes_versions" "latest" {
  version_prefix = "1.21."
}

data "digitalocean_sizes" "small" {
  filter {
    key    = "slug"
    values = ["s-2vcpu-2gb"]
  }
}

resource "digitalocean_kubernetes_cluster" "titanic-api" {
  name = "titanic-api"
  region = var.digitalocean_region

  # Latest patched version of DigitalOcean Kubernetes.
  version = data.digitalocean_kubernetes_versions.latest.latest_version

  # We want any Kubernetes Patches to be added to our cluster automatically.
  # With the version also set to the latest version, this will be covered from two perspectives
  auto_upgrade = true

  maintenance_policy {
    # Run patch upgrades at 4AM on a Sunday morning.
    start_time = "04:00"
    day = "sunday"
  }

  node_pool {
    # We need a default pool for our Kubernetes cluster
    name = "default"

    # We want to use small sizes to start off with
    size = element(data.digitalocean_sizes.small.sizes, 0).slug

    # We can auto scale our cluster according to use, and if it gets high,
    # We can auto scale to maximum 5 nodes.
    auto_scale = true
    min_nodes = 1
    max_nodes = 5

    # These labels will be available in the node objects inside of Kubernetes,
    # which we can use as taints and tolerations for workloads.
    labels = {
      pool = "default"
      size = "small"
    }
  }
}
