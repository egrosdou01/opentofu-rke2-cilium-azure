# Rancher RKE2 Cluster Powered by Cilium in Azure

## Introduction

The repository is a showcase of the blog post found [here](https://egrosdou01.github.io/personal-blog/blog/opentofu-rke2-cilium-azure.md). The code allows you to create an RKE2 cluster powered with [Cilium](https://docs.cilium.io/en/stable/) in Azure using the `free-credits` concept.

If you have an Azure subscription, update the code to reflect an RKE2 cluster in a different region, with more resources and nodes attached.

## Pre-prerequisites
1. Rancher server already installed
1. Azure free-credits subscription
1. OpenTofu binary installed

## Execute OpenTofu Plan
```bash
1. tofu init
2. tofu plan
3. tofu apply
```
## Delete Resources

```bash
$ tofu destroy
```

## Tested Versions
| SOFTWARE | VERSION | DOCS |
|:---------|:--------|:-----|
| kube-vip                    | 0.8.2           | <https://kube-vip.io/docs> |
| Rancher Server              | 2.8.5 | <https://rancher.com/docs/rancher/v2.8/en/overview> |
| Rancher OpenTofu Provider   | 4.1.0            | <https://registry.terraform.io/providers/rancher/rancher2/latest/docs> |
| k3s                         | 1.28.x   | <https://docs.rke2.io> |
| OpenTofu                   | 1.8.1          | <https://opentofu.org/> |
| Azure Cloud                     |       | |