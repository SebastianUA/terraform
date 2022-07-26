# Terraform usage
----------------
![terraform-lint](https://github.com/SebastianUA/terraform/workflows/terraform-lint/badge.svg) ![](https://img.shields.io/github/last-commit/sebastianua/terraform.svg) ![](https://img.shields.io/github/repo-size/sebastianua/terraform.svg)  ![LatestVer](https://img.shields.io/github/release/sebastianua/terraform.svg) ![License](https://img.shields.io/badge/License-GPLv3-blue.svg)

## Install Terraform

- If you're using MacOS, then you can run the next command to install TF:
```bash
$ brew install terraform
```
NOTE: you must install `HOMEBREW` to your host something like:
```bash
$ sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
- For Unix/Linux OS you might go to the official Terraform site and download bin-file with software.

## Init

---------
First of all, you should clone this repo to your local machine. I provided modules with simple examples. After, go to needed example and run the next command:
```bash
$ terrafrom init
```

This command will init everything to provision module(s).


## Plan
---------
When you set `terraform init` you will be able to see which services are going to create with the next command:

```bash
$ terraform plan
```

If you're using `tfvars`, you can run the following command:

```bash
$ terraform plan -var-file terraform.tfvars
```

It's a good point to use `tfvars` for multiple environments, - as example.

## Apply
---------
To apply your stack, you can use:

```bash
$ terraform apply
```

Or:

```bash
$ terraform apply -var-file terraform.tfvars
```

Also, you can use `-auto-approve` command to automatically apply the stack.

## Destroy
---------
To terminate the stack, use:

```bash
$ terraform destroy
```

Or:

```bash
 $ terraform destroy -var-file terraform.tfvars
```

Also, you can use `-auto-approve` command to automatically terminate the stack.

## graph

If you're using mac OS, you must install the next package:
```bash
$ brew install graphviz
```

Then, run:
```bash
$ terraform graph | dot -Tsvg > graph.svg

$ terraform graph | dot -Tpng > graph.png
```

## state

If you would like to remove your stack from TF statefile, you can use this command:

```bash
$ terraform state rm "module.rds_single_mysql.aws_db_subnet_group.db_subnet_group[0]"
```

The structura is the next one: `module.<MODULE_NAME>.<RESOURCE_NAME>.<NAME_of_RESOURCE>[count.index]`.

Where:

- MODULE_NAME - The module name.
- RESOURCE_NAME - the resource name of provider.
- NAME_of_RESOURCE - The name of resource of created RESOURCE_NAME.
- [count.index] - Index of resource in loop.

That's it.

## import

If you would like to import some stack stack to TF, you can use this command:

```bash
$ terraform import --var 'db_password=PW_HERE' "module.rds_single_mysql.aws_db_subnet_group.db_subnet_group[0]" "terraform-20220711082550455200000001"
```

The structura is the next one: `module.<MODULE_NAME>.<RESOURCE_NAME>.<NAME_of_RESOURCE>[count.index] <IMPORTING_VALUE> ` .

Where:

- MODULE_NAME - The module name.
- RESOURCE_NAME - the resource name of provider.
- NAME_of_RESOURCE - The name of resource of created RESOURCE_NAME.
- [count.index] - Index of resource in loop.
- IMPORTING_VALUE - The value to import.

That's it.

## Help

---------

To get help, use:

```bash
$ terraform -help
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Experimental support for module integration testing
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.
```

## Auto-switching Terraform version

---------

The `tfswitch` command line tool lets you switch between different versions of [terraform](https://www.terraform.io/). If you do not have a particular version of terraform installed, `tfswitch` lets you download the version you desire. The installation is minimal and easy. Once installed, simply select the version you require from the dropdown and start using terraform.

To install this tool for macOS:

```bash
$ brew install warrensbox/tap/tfswitch
```

Linux:

```bash
 $ curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
```

Snapcraft for CentOS, Ubuntu, Linux Mint, RHEL, Debian, Fedora:

```bash
$ sudo snap install tfswitch
```

**Automatically switch with bash**

Add the following to the end of your `~/.bashrc` file: (Use either `.tfswitchrc` or `.tfswitch.toml` or `.terraform-version`):

```bash
cdtfswitch(){
  builtin cd "$@";
  cdir=$PWD;
  if [ -e "$cdir/.tfswitchrc" ]; then
    tfswitch
  fi
}
alias cd='cdtfswitch'
```

**Automatically switch with zsh**

Add the following to the end of your `~/.zshrc` file:

```bash
load-tfswitch() {
  local tfswitchrc_path=".tfswitchrc"

  if [ -f "$tfswitchrc_path" ]; then
    tfswitch
  fi
}
add-zsh-hook chpwd load-tfswitch
load-tfswitch
```

To get list of the supported version of the software, run the next command:

```bash
$ tfswitch -l
```

Or:

 ```bash
$ tfswitch --list-all
 ```

Scroll up or down to see versions. Click on needed to use it.

If a `*.tf` file with the terraform constrain is included in the current directory, it should automatically download or switch to that terraform version. For example, the following should automatically switch terraform to the lastest version:

```bash
terraform {
  required_version = ">= 0.13.9"

  required_providers {
    aws        = ">= 2.52.0"
    kubernetes = ">= 1.11.1"
  }
}
```

I really like this tool and it can be used for your locally run as well as for CI/CD.

## Module Sources

The source argument in a module block tells Terraform where to find the source code for the desired child module.

Terraform uses this during the module installation step of terraform init to download the source code to a directory on local disk so that it can be used by other Terraform commands.

### Local Paths
Local path references allow for factoring out portions of a configuration within a single source repository:
```
module "vpc" {
  source = "../aws/modules/vpc"
}
```

A local path must begin with either ./ or ../ to indicate that a local path is intended, to distinguish from a module registry address.

Local paths are special in that they are not "installed" in the same sense that other sources are: the files are already present on local disk (possibly as a result of installing a parent module) and so can just be used directly. Their source code is automatically updated if the parent module is upgraded.

### Terraform Registry
A module registry is the native way of distributing Terraform modules for use across multiple configurations, using a Terraform-specific protocol that has full support for module versioning.

Terraform Registry is an index of modules shared publicly using this protocol. This public registry is the easiest way to get started with Terraform and find modules created by others in the community:
```
module "consul" {
  source = "hashicorp/consul/aws"
  version = "0.1.0"
}
```

### GitHub

Terraform will recognize unprefixed github.com URLs and interpret them automatically as Git repository sources:
```
module "consul" {
  source = "github.com/hashicorp/example"
}
```

Or:
```
module "ram" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/ram?ref=dev"
}
```
Arbitrary Git repositories can be used by prefixing the address with the special git:: prefix. After this prefix, any valid Git URL can be specified to select one of the protocols supported by Git.

For example, to use HTTPS or SSH:
```
module "vpc" {
  source = "git::https://example.com/vpc.git"
}

module "storage" {
  source = "git::ssh://username@example.com/storage.git"
}
```

### Fetching archives over HTTP
As a special case, if Terraform detects that the URL has a common file extension associated with an archive file format then it will bypass the special terraform-get=1 redirection described above and instead just use the contents of the referenced archive as the module source code:
```
module "vpc" {
  source = "https://example.com/vpc-module.zip"
}
```

### S3 Bucket
You can use archives stored in S3 as module sources using the special s3:: prefix, followed by an S3 bucket object URL:
```
module "consul" {
  source = "s3::https://s3-eu-west-1.amazonaws.com/examplecorp-terraform-modules/vpc.zip"
}
```

And others.

## Using Terraform for multiple AWS accounts

You can optionally define multiple configurations for the same provider, and select which one to use on a per-resource or per-module basis. The primary reason for this is to support multiple regions for a cloud platform; other examples include targeting multiple Docker hosts, multiple Consul hosts, etc.

To create multiple configurations for a given provider, include multiple provider blocks with the same provider name. For each additional non-default configuration, use the alias meta-argument to provide an extra name segment. For example:
```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Account from resoure will be shared (owner)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "owner"

  alias = "owner"
}

module "ram_owner" {
  source      = "git@github.com:SebastianUA/terraform.git//aws/modules/ram?ref=dev"
  name        = "tmp"
  environment = "dev"

  providers = {
    aws = aws.owner
  }

  # RAM resource share
  enable_ram_resource_share                    = true
  ram_resource_share_name                      = "test-ram-shared-resource-1"
  ram_resource_share_allow_external_principals = true

  # RAM resource association
  enable_ram_resource_association       = true
  ram_resource_association_resource_arn = "arn:aws:ec2:YOUR_REGION_HERE:YOUR_AWSID_HERE:transit-gateway/tgw-095a7bb025f42d2b0"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Account to resoure will be shared (main)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "main"
}

module "ram_main_accepter" {
  source      = "git@github.com:SebastianUA/terraform.git//aws/modules/ram?ref=dev"
  name        = "tmp"
  environment = "dev"

  # RAM principal association
  enable_ram_principal_association             = true
  ram_principal_association_resource_share_arn = module.ram_owner.ram_resource_share_id
  ram_principal_association_principal          = data.aws_caller_identity.current.account_id

  # RAM resource share accepter
  enable_ram_resource_share_accepter    = true
  ram_resource_share_accepter_share_arn = module.ram_owner.ram_principal_association_id

  depends_on = [
    module.ram_owner
  ]
}
```
The official documentation is https://www.terraform.io/docs/language/providers/configuration.html#provider-versions.



## Cloud cost estimates for Terraform

Infracost shows cloud cost estimates for infrastructure-as-code projects such as Terraform. It helps developers, devops and others to quickly see a cost breakdown and compare different options upfront.

## Installation

1. Assuming [Terraform](https://www.terraform.io/downloads.html) is already installed, get the latest Infracost release:

   macOS Homebrew:

   ```
   brew install infracost
   ```

   Linux/macOS manual download:

   ```
   os=$(uname | tr '[:upper:]' '[:lower:]') && \
   arch=$(uname -m | tr '[:upper:]' '[:lower:]' | sed -e s/x86_64/amd64/) && \
   curl -s -L https://github.com/infracost/infracost/releases/latest/download/infracost-$os-$arch.tar.gz | tar xz -C /tmp && \
   sudo mv /tmp/infracost-$os-$arch /usr/local/bin/infracost
   ```

   Docker and Windows users see [here](https://www.infracost.io/docs/#installation).

2. Register for a free API key:

   ```
   infracost register
   ```

   The key is saved in `~/.config/infracost/credentials.yml`.

3. Run Infracost using our example Terraform project to see how it works:

   ```
   git clone https://github.com/infracost/example-terraform.git
   cd example-terraform
   
   # Play with sample1/main.tf and re-run to compare costs
   infracost breakdown --path sample1
   
   # Show diff of monthly costs, edit the yaml file and re-run to compare costs
   infracost diff --path sample1 --usage-file sample1/infracost-usage.yml
   ```

Please **watch/star** this repo as we add new cloud resources every week or so.

## Usage

The `infracost` CLI has the following main commands, their usage is described in our short [**getting started**](https://www.infracost.io/docs/#usage) page:

- `breakdown`: show full breakdown of costs
- `diff`: show diff of monthly costs between current and planned state

As mentioned in our [FAQ](https://www.infracost.io/docs/faq), **no** cloud credentials, secrets, tags or resource identifiers are sent to the Cloud Pricing API. That API does not become aware of your cloud spend; it simply returns cloud prices to the CLI so calculations can be done on your machine. Infracost does not make any changes to your Terraform state or cloud resources.

## CI/CD integrations

The following CI/CD integrations can be used to automatically add a pull request comment showing the diff of monthly costs between the current and planned state:

- [GitHub Action](https://www.infracost.io/docs/integrations/cicd#github-action)
- [GitLab CI template](https://www.infracost.io/docs/integrations/cicd#gitlab-ci)
- [CircleCI Orb](https://www.infracost.io/docs/integrations/cicd#circleci)
- [Bitbucket Pipeline](https://www.infracost.io/docs/integrations/cicd#bitbucket-pipelines)
- [Atlantis](https://www.infracost.io/docs/integrations/cicd#atlantis)

If you run into any issues with CI/CD integrations, please join our [community Slack channel](https://www.infracost.io/community-chat), we'd be happy to guide you through it. The GitHub page is https://github.com/infracost/infracost.

## Auto-generate documentation for Terraform modules

---------

I have a python script to generate the `README.md` file-based on Terraform modules and examples that I'm supporting. The code can be found here:  [generate-tf-docs](https://github.com/SebastianUA/generate-tf-docs).

## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License
Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
