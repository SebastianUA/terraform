# Terraform usage
----------------
![terraform-lint](https://github.com/SebastianUA/terraform/workflows/terraform-lint/badge.svg)|![](https://img.shields.io/github/last-commit/sebastianua/terraform.svg)|![](https://img.shields.io/github/repo-size/sebastianua/terraform.svg)|![LatestVer](https://img.shields.io/github/release/sebastianua/terraform.svg)|![License](https://img.shields.io/badge/License-GPLv3-blue.svg)

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

## Help

---------

To get help, use:

```bash
$ terraform help
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    env                Workspace management
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a Terraform working directory
    login              Obtain and save credentials for a remote host
    logout             Remove locally-stored credentials for a remote host
    output             Read an output from a state file
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Validates the Terraform files
    version            Prints the Terraform version
    workspace          Workspace management

All other commands:
    0.12upgrade        Rewrites pre-0.12 module source code for v0.12
    0.13upgrade        Rewrites pre-0.13 module source code for v0.13
    debug              Debug output management (experimental)
    force-unlock       Manually unlock the terraform state
    push               Obsolete command for Terraform Enterprise legacy (v1)
    state              Advanced state management``` 
```

## Tfswitch

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

## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License
Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
