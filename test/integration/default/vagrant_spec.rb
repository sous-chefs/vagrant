describe command('vagrant --version') do
  its('stdout') { should match(/Vagrant 1.8.5/) }
  its('stderr') { should eq '' }
end

describe command('vagrant plugin list') do
  its('stdout') { should match(/vagrant-ohai/) }
  its('exit_status') { should eq 0 }
end
