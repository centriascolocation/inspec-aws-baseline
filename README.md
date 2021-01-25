<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [InSpec AWS Baseline Profile](#inspec-aws-baseline-profile)
    - [Usage](#usage)
        - [IAM Permissions](#iam-permissions)
        - [Profile Execution - variant A](#profile-execution-variant-a)
        - [Profile Execution - variant B](#profile-execution-variant-b)
        - [Re-Vendor Dependencies](#re-vendor-dependencies)
    - [AWS Organizations](#aws-organizations)
    - [Further Information](#further-information)
        - [The Importance of Compliance Results](#the-importance-of-compliance-results)

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
    * Security Groups for SSH are restricted :white_check_mark:
    * Security Groups for Remote Desktop (RDP) are restricted :white_check_mark:
  * additional best-practices not covered by the CIS Benchmark:
    * all your S3 Buckets are not public and encrypted (per Region) :white_check_mark:
    * Organizations :white_check_mark:
    * all your EBS volumes should be encrypted (per region) :white_check_mark:
    * ECR: Test that images are scanned for vulnerabilities at a push to repository :white_check_mark:

## Usage

Please make sure you have InSpec version >= 4 installed, e.g. with `bundle install` (see [Gemfile](Gemfile) for details). 

**We recommend the usage of [aws-vault](https://github.com/99designs/aws-vault).**

### IAM Permissions

Make sure your Auditor IAM User has the following managed policy attached:

`arn:aws:iam::aws:policy/SecurityAudit`

It is also possible to use higher privileged policies, such as `arn:aws:iam::aws:policy/ReadOnlyAccess`.

### Profile Execution - variant A

You can easily use this InSpec profile from Github:


```

  ## the "-n" instructs aws-vault not to use AWS STS session tokens:
  aws-vault exec -n <YOURNAMEDPROFILEHERE> -- inspec exec \
    -t aws:// --show-progress \
    https://github.com/centriascolocation/inspec-aws-baseline/archive/master.tar.gz

```

### Profile Execution - variant B

Call InSpec with AWS region + your local configured Profile:

```

  inspec exec -t aws://eu-central-1/my-named-profile --show-progress \
    https://github.com/centriascolocation/inspec-aws-baseline/archive/master.tar.gz
  
```

### Re-Vendor Dependencies

```

  inspec vendor --overwrite . 

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

## Further Information

### The Importance of Compliance Results

These values are based off [CVSS 3.0](https://en.wikipedia.org/wiki/Common_Vulnerability_Scoring_System): 

| numeric value | impact, importance |
| ------------- | ------------------ |
| 0.0 to <0.01  | `none` - they only provide information |
| 0.01 to <0.4  | `low` |
| 0.4 to <0.7   | `medium` |
| 0.7 to <0.9   | `high` |
| 0.9 to 1.0    | `critical` |