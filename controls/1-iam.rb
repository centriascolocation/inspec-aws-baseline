
title '1 CIS Amazon Web Services Foundations Benchmark, version 1.2.0, IAM section'

control 'cis-amazon-web-services-foundation-benchmark-1.2' do

  impact 1.0
  title "Ensure multi-factor authentication (MFA) is enabled for all IAM users that have a console password"
  desc "It is recommended that MFA be enabled for all accounts that have a console password."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.2'
  tag level: 1

  describe aws_iam_users.where(has_console_password: true) do
    it { should exist }
  end

  console_users_without_mfa = aws_iam_users
                                .where(has_console_password: true)
                                .where(has_mfa_enabled: false)

  describe console_users_without_mfa do
    it { should_not exist }
  end
end

control 'cis-amazon-web-services-foundation-benchmark-1.3' do
  impact 1.0
  title 'Ensure credentials unused for 90 days or greater are disabled'
  desc 'It is recommended that all credentials that have been unused in 90 or greater days be removed or deactivated.'

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.2'
  tag level: 1
  tag CCE: '78900-8'

  describe('cis-amazon-web-services-foundation-benchmark-1.3') do
    skip 'Not implemented'
  end

end

control 'cis-amazon-web-services-foundation-benchmark-1.4' do
  impact 1.0
  title 'Ensure access keys are rotated every 90 days or less'
  desc 'It is recommended that all access keys be regularly rotated.'

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.2'
  tag level: 1

  u = aws_iam_users
  usernames = u.usernames

  usernames.each do |user|
    aks = aws_iam_access_keys(username: user)
    aks_ids = aks.access_key_ids

    aks_ids.each do |ak|
      describe aws_iam_access_key(id: ak, username: user) do
        its('create_date') { should be > Time.now - 90 * 86400 }
     end
    end
  end
end

control 'cis-amazon-web-services-foundation-benchmark-1.5' do
  impact 1.0
  title 'Ensure IAM password policy requires at least one uppercase letter'
  desc "It isrecommended that the password policy require at least one uppercase letter."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.5'
  tag level: 1

  describe aws_iam_password_policy do
    it { should require_uppercase_characters }
  end
end

control 'cis-amazon-web-services-foundation-benchmark-1.6' do
  impact 1.0
  title 'Ensure IAM password policy require at least one lowercase letter'
  desc "It is recommended that the password policy require at least one lowercase letter."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.6'
  tag level: 1

  describe aws_iam_password_policy do
    it { should require_lowercase_characters }
  end
end

control 'cis-amazon-web-services-foundation-benchmark-1.7' do
  impact 1.0
  title 'Ensure IAM password policy require at least one symbol'
  desc "It is recommended thatthe password policy require at least one symbol."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.7'
  tag level: 1

  describe aws_iam_password_policy do
    it { should require_symbols }
  end
end

control 'cis-amazon-web-services-foundation-benchmark-1.8' do
  impact 1.0
  title 'Ensure IAM password policy require at least one number'
  desc "It is recommended that the password policy require at least one number."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.8'
  tag level: 1

  describe aws_iam_password_policy do
    it { should require_numbers }
  end
end

control 'cis-amazon-web-services-foundation-benchmark-1.9' do
  impact 1.0
  title 'Ensure IAM password policy requires minimum length of 14 or greater'
  desc "It is recommended that the password policy require a minimum password length 14."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.9'
  tag level: 1

  describe aws_iam_password_policy do
    its('minimum_password_length') { should be > 14 }
  end
end

control 'cis-amazon-web-services-foundation-benchmark-1.13' do
  impact 1.0
  title 'Ensure MFA is enabled for the "root" account'
  desc "The root account is the most privileged user in an AWS account."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.13'
  tag level: 1
  describe aws_iam_root_user do
    it { should have_mfa_enabled }
  end
end
