ENV['HOME'] = '/root'

describe file('/usr/local/bin/vagrant') do
  it { should be_file }
end

describe command('/usr/local/bin/vagrant --version') do
  its('stdout') { should match(/Vagrant 2.3.0/) }
  its('stderr') { should eq '' }
end

describe command("sudo su  -c 'cd /root && /usr/local/bin/vagrant plugin list'") do
  its('stdout') { should match(/vagrant-ohai/) }
  its('stdout') { should match(/vagrant-berkshelf/) }
  its('stdout') { should match(/vagrant-omnibus/) }
  its('exit_status') { should eq 0 }
end
