describe command('vagrant --version') do
  its('stdout') { should match(/Vagrant 2.2.4/) }
  its('stderr') { should eq '' }
end

describe command('vagrant plugin list') do
  its('stdout') { should_not match(/vagrant-ohai/) }
  its('stdout') { should match(/vagrant-vbguest/) }
  its('exit_status') { should eq 0 }
end
