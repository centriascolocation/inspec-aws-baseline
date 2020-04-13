title '99 Additional Controls focused on Best Practices - Organizations'

check_aws_organizations_member = input('check_aws_organizations_member')
check_aws_organizations_master = input('check_aws_organizations_master')
master_account_id = input('master_account_id')
master_account_name = input('master_account_name')
master_account_email = input('master_account_email')

control 'organizations-member-99.2.1' do
  only_if do
    check_aws_organizations_member == true
  end

  title "Check whether this Account is a member of a given Organization"
  desc "Ensure you are a child account with a certain ID for the top level account."

  describe aws_organizations_member do
    it                       { should_not be_master }
    its('master_account_id') { should cmp master_account_id }
  end
end

control 'organizations-master-99.2.2' do
  only_if do
    check_aws_organizations_master == true
  end

  title "Check whether this is the Master Account in an AWS Organization"
  desc "Ensure you are the top level account, with the right name and email associated."

  describe aws_organizations_member do
    it                   { should be_master }
    its('account_name')  { should eq master_account_name }
    its('account_email') { should eq master_account_email }
  end
end
