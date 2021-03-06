title '2 CIS Amazon Web Services Foundations Benchmark, version 1.2.0, Logging section'

control 'cis-amazon-web-services-foundation-benchmark-2.1' do
  impact 'high'
  title 'Ensure CloudTrail is enabled in all regions (Scored)'
  desc 'The AWS API call history produced by CloudTrail enables security analysis, resource change tracking, and compliance auditing.'
  tag level: 1

  describe aws_cloudtrail_trails do
    its('entries.count') { should be >= 1 }
  end
end

control 'cis-amazon-web-services-foundation-benchmark-2.5' do
  impact 'medium'
  title 'Ensure AWS Config is enabled in all regions (Scored)'
  desc "It is recommended to enable AWS Config be enabled in all regions."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:2.5'
  tag level: 1

  describe aws_config_recorder do
    it { should exist }
    it { should be_recording }
  end

  describe aws_config_delivery_channel do
    it { should exist }
  end
end
