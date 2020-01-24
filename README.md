# InSpec AWS Baseline Profile

:exclamation: This is work in progress, only a few controls are implemented by now.

This profile covers some parts of the "CIS Amazon Web Services Foundations Benchmark (v1.2.0)".

  * IAM
  * Logging
  * Monitoring
  * Networking

## Usage

Please make sure you have InSpec version >= 4 installed. 

**We recommend the usage of [aws-vault](https://github.com/99designs/aws-vault).**

You can easily use this InSpec profile from Github:

```
  ## the "-n" instructs aws-vault not to use AWS STS session tokens:
  aws-vault exec -n <YOURNAMEDPROFILEHERE> -- inspec exec --show-progress https://github.com/centriascolocation/inspec-aws-baseline/archive/master.tar.gz -t aws://

```
