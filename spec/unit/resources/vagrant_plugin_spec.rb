# frozen_string_literal: true

require 'spec_helper'

describe 'vagrant_plugin' do
  step_into :vagrant_plugin
  platform 'ubuntu', '24.04'

  let(:plugin) { instance_double(Vagrant::Plugin) }

  before do
    allow(Vagrant::Plugin).to receive(:new).and_return(plugin)
  end

  context 'with action install' do
    recipe do
      vagrant_plugin 'vagrant-ohai' do
        version '1.2.3'
        sources ['https://plugins.example.test']
      end
    end

    before do
      allow(plugin).to receive(:install?).with('1.2.3').and_return(true)
    end

    it 'installs the plugin' do
      expect(plugin).to receive(:install).with('1.2.3', ['https://plugins.example.test'])
      subject
    end
  end

  context 'with action remove' do
    recipe do
      vagrant_plugin 'vagrant-ohai' do
        action :remove
      end
    end

    before do
      allow(plugin).to receive(:installed?).and_return(true)
    end

    it 'uninstalls the plugin' do
      expect(plugin).to receive(:uninstall)
      subject
    end
  end
end
