# frozen_string_literal: true

ENV['HOME'] = '/root'

describe file('/usr/local/bin/vagrant') do
  it { should be_file }
end

describe command('/usr/local/bin/vagrant --version') do
  its('stdout') { should match(/Vagrant 2.4.9/) }
  its('stderr') { should eq '' }
end
