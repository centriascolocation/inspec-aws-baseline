# InSpec AWS Baseline Profile

[![centriascolocation](https://circleci.com/gh/centriascolocation/inspec-aws-baseline.svg?style=svg)](https://circleci.com/gh/centriascolocation/inspec-aws-baseline)

:exclamation: This is work in progress, only a few controls are implemented by now.

This profile covers some parts of the "CIS Amazon Web Services Foundations Benchmark (v1.2.0)".

  * IAM
  * Logging
  * Monitoring
  * Networking
  * additional best-practices not covered by the CIS Benchmark:
    * S3 (not public and encrypted)
    * Organizations

## Usage

Please make sure you have InSpec version >= 4 installed, e.g. with `bundle install` (see [Gemfile](Gemfile) for details). 

**We recommend the usage of [aws-vault](https://github.com/99designs/aws-vault).**

You can easily use this InSpec profile from Github:


```

  ## the "-n" instructs aws-vault not to use AWS STS session tokens:
  aws-vault exec -n <YOURNAMEDPROFILEHERE> -- inspec exec \
     -t aws:// --show-progress \
    https://github.com/centriascolocation/inspec-aws-baseline/archive/master.tar.gz

```

## AWS Organizations

You can also check if a given account is part of AWS Organizations (Master or Member). This feature is disabled by default.
You can enable it by providing variables given as an [InSpec Input File](https://www.inspec.io/docs/reference/inputs/). 

[See example configurations here](enable-aws-organizations-checks.yml).

```

  aws-vault exec -n <YOURNAMEDPROFILEHERE> -- inspec exec \
    https://github.com/centriascolocation/inspec-aws-baseline/archive/master.tar.gz \
    -t aws:// --show-progress \
    --input-file enable-aws-organizations-checks.yml

```