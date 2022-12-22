describe command('vagrant --version') do
  its('stdout') { should match(/Vagrant 2.3.0/) }
  its('stderr') { should eq '' }
end

describe command('vagrant plugin list') do
  its('stdout') { should match(/vagrant-ohai/) }
  its('exit_status') { should eq 0 }
end

describe command('vagrant plugin list') do
  its('stdout') { should match(/vagrant-winrm/) }
  its('stdout') { should match(/vagrant-omnibus/) }
end
