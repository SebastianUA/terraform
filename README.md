# Terraform usage
----------------
![License](https://img.shields.io/badge/License-GPLv3-blue.svg)|![LatestVer](https://img.shields.io/github/release/sebastianua/terraform.svg)| ![](https://img.shields.io/github/repo-size/sebastianua/terraform.svg)| ![](https://img.shields.io/github/last-commit/sebastianua/terraform.svg)

## Install Terraform

- If you're using MacOS, then you can run the next command to install TF:
```
$ brew install terraform
```
NOTE: you must install `HOMEBREW` to your host:
```
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
- For Unix/Linux OS you might go to the official Terraform site and download bin-file with software.

## Init
---------
First of all, you should clone this repo to your local machine. I provided modules with simple examples.
```terrafrom init```


## Plan
---------
```terraform plan``` or ```terraform plan -var-file terraform.tfvars```

## Apply
---------
```terraform apply``` or ```terraform apply -var-file terraform.tfvars```

## Destroy
---------
```terraform destroy``` or ```terraform destroy -var-file terraform.tfvars```


## Authors
Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License
Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
