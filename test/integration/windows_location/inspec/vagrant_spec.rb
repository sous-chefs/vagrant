describe command('vagrant --version') do
  its('stdout') { should match(/Vagrant 2.0.3/) }
  its('stderr') { should eq '' }
end

describe file('C:\Users\altloc\plugins.json') do
  its('content') { should match(/vagrant-ohai/) }
  its('content') { should match(/vagrant-winrm/) }
  its('content') { should match(/vagrant-omnibus/) }
end
