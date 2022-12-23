describe package 'vagrant' do
  it { should_not be_installed }
end

describe command('vagrant --version') do
  its('exit_status') { should eq 127 }
end
