title '99 Additional Controls focused on Best Practices - EBS Volume Encryption and Usage'

control 'ebs-volumes-99.4' do
  title "EBS Volume Encryption"
  desc "All your EBS Volumes should be encrypted and attached to an EC2 instance ('in-use')"

  aws_ebs_volumes.volume_ids.each do |volume_id|
    describe aws_ebs_volume(volume_id) do
      it { should be_encrypted }
      its('state') { should cmp 'in-use' }
    end
  end
end
