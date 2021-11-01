describe command('vagrant --version') do
  its('stdout') { should match(/Vagrant 2.2.18/) }
  its('stderr') { should eq '' }
end

describe command("sudo su -c 'cd /root && vagrant plugin list'") do
  its('stdout') { should match(/vagrant-ohai/) }
  its('stdout') { should match(/vagrant-vbguest/) }
  its('exit_status') { should eq 0 }
end

describe command("sudo su  -c 'cd /root && vagrant plugin list'") do
  its('stdout') { should match(/vagrant-ohai/) }
  its('stdout') { should match(/vagrant-berkshelf/) }
  its('stdout') { should match(/vagrant-omnibus/) }
  its('exit_status') { should eq 0 }
end

if os[:family] == 'debian'
  describe command("sudo su -c 'cd /root && vagrant plugin list'") do
    its('stdout') { should match(/vagrant-libvirt/) }
  end
end
