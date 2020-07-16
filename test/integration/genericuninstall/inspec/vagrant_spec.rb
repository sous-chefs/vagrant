ENV['HOME'] = '/root'
describe file('/usr/local/bin/vagrant') do
  it { should_not exist }
end
