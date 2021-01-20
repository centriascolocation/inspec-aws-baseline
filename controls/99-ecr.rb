title '99 ECR Scan On Push'

control 'ecr-repositories-99.3' do
  title 'ECR scan on push is activated'
  desc 'Test that images are scanned for vulnerabilities at a push to repository'

  aws_ecr_repositories.names.each do |repository_name|
    describe aws_ecr_repository(repository_name) do
      its('image_scanning_configuration.scan_on_push') { should eq true }
    end
  end
end
