RSpec.shared_context 'mock vagrant_sha256sum' do
  before(:context) do
    RSpec.configure do |config|
      config.mock_with :rspec do |mocks|
        @vpd_setting = mocks.verify_partial_doubles?
        mocks.verify_partial_doubles = false
      end
    end
  end

  before(:example) do
    allow_any_instance_of(Chef::Recipe).to receive(:vagrant_sha256sum).and_return('abc123')
  end

  after(:context) do
    RSpec.configure do |config|
      config.mock_with :rspec do |mocks|
        mocks.verify_partial_doubles = @vpd_setting
      end
    end
  end
end

RSpec.shared_context 'mock vagrant_plugin_list' do
  before(:context) do
    RSpec.configure do |config|
      config.mock_with :rspec do |mocks|
        @vpd_setting = mocks.verify_partial_doubles?
        mocks.verify_partial_doubles = false
      end
    end
  end

  let(:windows_plugin_list) { "simple-plugin (0.1.0, system)\r\ntwo-digit-minor (1.12.34)\r\nvagrant-foobar (2.3.4)" }
  let(:unix_plugin_list) { windows_plugin_list.gsub(/\r\n/, "\n") }

  before(:example) do
    allow_any_instance_of(Chef::Provider).to receive(:vagrant_plugin_list).and_return(unix_plugin_list)
  end

  after(:context) do
    RSpec.configure do |config|
      config.mock_with :rspec do |mocks|
        mocks.verify_partial_doubles = @vpd_setting
      end
    end
  end
end
