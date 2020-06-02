<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [InSpec AWS Baseline Profile](#inspec-aws-baseline-profile)
  - [Usage](#usage)
  - [AWS Organizations](#aws-organizations)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# InSpec AWS Baseline Profile

[![centriascolocation](https://circleci.com/gh/centriascolocation/inspec-aws-baseline.svg?style=svg)](https://circleci.com/gh/centriascolocation/inspec-aws-baseline)

This profile covers some parts of the "CIS Amazon Web Services Foundations Benchmark (v1.2.0)".

Batteries included:

  * IAM
    * MFA for root account :white_check_mark:
    * Password Policy :white_check_mark:
    * all your Access Keys - Expiration :white_check_mark:
  * Logging
    * AWS Config is active :white_check_mark:
    * CloudTrail is enabled :white_check_mark:
  * Networking
    * Security Groups for SSH are not restricted :white_check_mark:
  * additional best-practices not covered by the CIS Benchmark:
    * all your S3 Buckets (per Region, not public and encrypted) :white_check_mark:
    * Organizations :white_check_mark:
    * all your EBS volumes should be encrypted (per region) :white_check_mark:

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