# frozen_string_literal: true

describe file('/usr/local/bin/vagrant') do
  it { should_not exist }
end
