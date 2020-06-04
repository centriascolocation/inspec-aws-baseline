title '99 Additional Controls focused on Best Practices - EBS Volume Encryption'

control 'ebs-volumes-99.4' do
  title "EBS Volume Encryption"
  desc "All your EBS Volumes should be encrypted"

  aws_ebs_volumes.volume_ids.each do |volume_id|
    describe aws_ebs_volume(volume_id) do
      it { should be_encrypted }
    end
  end
end
