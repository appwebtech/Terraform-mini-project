# Terraform

## Introduction 

Terraform is a tool for infrastructure provisioning. What does provisioning infra entail? This can mean;

1. Provisioning infrastructure
   * Creating a VPC
   * Spinning up servers
   * Creating AWS users and permissions
   * Installing Docker containers etc

When it comes to infrastructure provisioning, you can choose between **Ansible** and **Terraform**. Both are IaC but the following are the main differences.

1. Terraform
   * Mainly Infrastructure provisioning
   * Can also deploy apps and tools on that infra
   * Relatively new but much more advanced in orchestration
2. Ansible
   * Mainly a configuration tool (Configure infra)
      * Once the infra has been deployed, it can configure it and deploy apps.
      * Install/update software
   * More mature

Terraform (TF) has 2 main components that make up it's architecture.

1. **Terraform Core**
   * TF-Config (What to create or configure)
   * State (Where TF keeps how the current up to state of the infra looks like)
   TF core takes a snapshot of *current state* VS *desired state* (config file) and plans what needs to be created/updated/destroyed.

Terraform uses a declarative approach when updating the infra.

Terraform commands for different stages

```shell
refresh  # Query infra provider to get current state
plan # Create an execution plan
apply # execute the plan
destroy # destroy the resources/ infra
```

## Terraform State

Terraform must store state about your managed infrastructure and configuration. This [state](https://www.terraform.io/docs/language/state/index.html) is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.

This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment.


## Environment Variables

You can set up the environment variables in bash for the AWS credentials by either exporting them or running the following command;

```shell
aws configure   # It will ask you to input the necessary values

aws configure list   # Will show your credentials
```

You can export your region as an environment variable as well in bash. 

```shell
export TF_VAR_avail_zone="eu-west-1"
```

To reference the availability zone in your text editor, do the following;

```tf
variable avail_zone {}
```

Next topic is on provisioners which is in my [next branch](https://github.com/appwebtech/terraform-mini-project/tree/feature/provisioners).

## [Provisioners](https://github.com/appwebtech/terraform-mini-project/tree/feature/provisioners)

