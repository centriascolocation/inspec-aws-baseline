title '2 CIS Amazon Web Services Foundations Benchmark, version 1.2.0, Logging section'

control 'cis-amazon-web-services-foundation-benchmark-2.5' do
  impact 1.0
  title 'Ensure AWS Config is enabled in all regions (Scored)'
  desc "It is recommended to enable AWS Config be enabled in all regions."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:2.5'
  tag level: 1

  describe aws_config_recorder do
    it { should exist }
  end

  # describe aws_cloudtrail_trails do
  #  its('entries.count') { should be >= 1}
  # end
end
