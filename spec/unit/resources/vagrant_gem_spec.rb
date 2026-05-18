# frozen_string_literal: true

require 'spec_helper'

describe 'vagrant_gem' do
  step_into :vagrant_gem
  platform 'ubuntu', '24.04'

  context 'with action remove' do
    recipe do
      vagrant_gem 'vagrant'
    end

    it { is_expected.to remove_gem_package('vagrant') }
    it { is_expected.to remove_chef_gem('vagrant') }
  end
end
