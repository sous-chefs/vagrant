# frozen_string_literal: true

if os.arch == 'aarch64'
  describe file('/usr/local/bin/vagrant') do
    it { should be_file }
  end
else
  describe command('vagrant --version') do
    its('stdout') { should match(/Vagrant 2.4.9/) }
    its('stderr') { should eq '' }
  end
end
