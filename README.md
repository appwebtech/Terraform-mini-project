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

## [Provisioners](https://github.com/appwebtech/terraform-mini-project/tree/feature/provisioners)

A **remote-exec** provisioner allows us to connect to a remote server and execute commands in that server.

A **file** provisioner is used to copy files or directories from local to newly created resources.

Adding the following code inside the EC2 instance block will create a provisioner which will export the environment variable **DEV** and create a new directory **newdir**. A script can also be used, which is common. The remote must already exist in the remote server.


```terraform
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private-key-location)
  }

  provisioner "file" {
     source = "entry-script.sh"
     destination = "/home/ec2-user"
  }

  provisioner "remote-exec" {
    inline = [
      "export ENV=dev",
      "mkdir newdir"
    ]
  }
```

The last provisioner is called **local-exec** which invokes a local executable (LOCALLY) after a resource has been created.

```terraform 
provisioner "local-exec" {
    command = "echo ${self.public_ip} > output.txt"
  }
```

Provisioners are a last resort and not recommended by Terraform because they break **idempotency** concept.

**Idempotency** means that no matter how many times a task is executed, it should always give you the same results. Instead of using scripts inside Terraform, it's recommended you use configuration management tools like **Chef, Puppet, Ansible, etc** once the server is provisioned.

See Terraform modules in the next [branch]

## [Modules](https://github.com/appwebtech/terraform-mini-project/tree/feature/modules)

A module is a container for multiple resources, used together. We use them to organize and group configurations into distinct logical components enabling re-use capabilities. I will create modules for the subnet and webserver and parameterize recurring objects.


