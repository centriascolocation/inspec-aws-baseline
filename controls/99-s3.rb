title '99 Additional Controls focused on Best Practices - S3'

control 's3-public-buckets-99.1' do
  title "S3 Public Buckets with Default Encryption enabled"
  desc "All your S3 Buckets should not be public accessible and the AES256 default Encryption should be enabled."
  ref 'AWS Security Hub, Section S3.5', url: 'https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-fsbp-controls.html#s3-5-remediation'

  all_buckets = aws_s3_buckets.bucket_names

  all_buckets.each do |b|
    describe aws_s3_bucket(b) do
      it { should_not be_public }
      it { should have_default_encryption_enabled }

      ## S3 buckets should require requests to use Secure Socket Layer:
      it { should have_secure_transport_enabled }
    end
  end

end
