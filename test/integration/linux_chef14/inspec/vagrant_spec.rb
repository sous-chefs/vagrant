describe command('vagrant --version') do
  its('stdout') { should match(/Vagrant 2.1.5/) }
  its('stderr') { should eq '' }
end

describe command('vagrant plugin list') do
  its('stdout') { should match(/vagrant-ohai/) }
  its('stdout') { should match(/vagrant-vbguest/) }
  its('exit_status') { should eq 0 }
end

describe command("sudo su  -c 'cd /root && vagrant plugin list'") do
  its('stdout') { should match(/vagrant-ohai/) }
  its('stdout') { should match(/vagrant-berkshelf/) }
  its('stdout') { should match(/vagrant-dns/) }
  its('exit_status') { should eq 0 }
end

if os[:family] == 'debian'
  describe command('vagrant plugin list') do
    its('stdout') { should match(/vagrant-libvirt/) }
  end
end

if os[:family] == 'windows'
  describe command('vagrant plugin list') do
    its('stdout') { should match(/vagrant-winrm/) }
    its('stdout') { should match(/vagrant-omnibus/) }
  end
end
