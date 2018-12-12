# InSpec AWS Baseline Profile

:exclamation: This is work in progress, only a few controls are implemented by now.

This profile covers some parts of the "CIS Amazon Web Services Foundations Benchmark (v1.2.0)".

  * IAM
  * Logging
  * Monitoring
  * Networking

## Usage

You can easily use this InSpec profile from github:

```

  ## assume role before to set AWS profile, credentials, token for that terminal session:
  brew install remind101/formulae/assume-role
  eval $(assume-role <YOUR-NAMED-AWS-PROFILE>)

  inspec exec https://github.com/centriascolocation/inspec-aws-baseline -t aws://

```
