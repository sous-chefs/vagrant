require 'spec_helper'
require_relative '../../../libraries/helpers'

RSpec.describe Vagrant::Cookbook::Helpers do
  class DummyClass < Chef::Node
    include Vagrant::Cookbook::Helpers
  end

  let(:platform_family) { 'mac_os_x' }
  let(:platform) { 'mac_os_x' }

  subject { DummyClass.new }

  before do
    allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
    allow(subject).to receive(:[]).with('platform').and_return(platform)
    allow(subject).to receive(:package_version).and_return('1.7.4')
    allow(subject).to receive(:fetch_platform_checksums_for_version).and_return(checksums)
  end

  let(:checksums) do
    [
      '3d2e680cc206ac1d480726052e42e193eabce56ed65fc79b91bc85e4c7d2deb8  vagrant_1.7.4.dmg',
      'a1ca7d99f162e001c826452a724341f421adfaef3e1366ee504b73ad19e3574f  vagrant_1.7.4.msi',
      '050411ba8b36e322c4ce32990d2539e73a87fabd932f7397d2621986084eda6a  vagrant_1.7.4_i686.deb',
      'f83ea56f8d1a37f3fdf24dd4d14bf8d15545ed0e39b4c1c5d4055f3de6eb202d  vagrant_1.7.4_i686.rpm',
      'dcd2c2b5d7ae2183d82b8b363979901474ba8d2006410576ada89d7fa7668336  vagrant_1.7.4_x86_64.deb',
      'b0a09f6e6f9fc17b01373ff54d1f5b0dc844394886109ef407a5f1bcfdd4e304  vagrant_1.7.4_x86_64.rpm',
    ]
  end

  it 'returns the correct Vagrant package URL' do
    expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4.dmg'
  end

  it 'returns the correct SHA256 checksum for the mac_os_x package' do
    expect(subject.vagrant_sha256sum).to eq '3d2e680cc206ac1d480726052e42e193eabce56ed65fc79b91bc85e4c7d2deb8'
  end

  context 'rhel' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform').and_return(platform)
    end

    let(:platform_family) { 'rhel' }
    let(:platform) { 'centos' }

    it 'returns the correct Vagrant package URL' do
      expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4_x86_64.rpm'
    end

    it 'returns the correct SHA256 checksum for the RHEL package' do
      expect(subject.vagrant_sha256sum).to eq 'b0a09f6e6f9fc17b01373ff54d1f5b0dc844394886109ef407a5f1bcfdd4e304'
    end
  end

  context 'debian' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform').and_return(platform)
    end

    let(:platform_family) { 'debian' }
    let(:platform) { 'ubuntu' }

    it 'returns the correct Vagrant package URL' do
      expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4_x86_64.deb'
    end

    it 'returns the correct SHA256 checksum for the Debian package' do
      expect(subject.vagrant_sha256sum).to eq 'dcd2c2b5d7ae2183d82b8b363979901474ba8d2006410576ada89d7fa7668336'
    end
  end

  context 'windows 64bit' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform').and_return(platform)
      allow(subject).to receive(:[]).with('kernel').and_return(machine)
      allow(subject).to receive(:[]).with('kernel').and_return(machine)
    end

    let(:platform_family) { 'windows' }
    let(:platform) { 'windows' }
    let(:machine) { { 'machine' => 'x86_64' } }

    it 'returns the correct Vagrant package URL' do
      expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4.msi'
    end

    it 'returns the correct SHA256 checksum for the Windows package' do
      expect(subject.vagrant_sha256sum).to eq 'a1ca7d99f162e001c826452a724341f421adfaef3e1366ee504b73ad19e3574f'
    end
  end

  context 'windows 32bit' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform').and_return(platform)
      allow(subject).to receive(:[]).with('kernel').and_return(machine)
      allow(subject).to receive(:[]).with('kernel').and_return(machine)
    end

    let(:platform_family) { 'windows' }
    let(:platform) { 'windows' }
    let(:machine) { { 'machine' => 'i686' } }

    it 'returns the correct Vagrant package URL' do
      expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4.msi'
    end

    it 'returns the correct SHA256 checksum for the Windows package' do
      expect(subject.vagrant_sha256sum).to eq 'a1ca7d99f162e001c826452a724341f421adfaef3e1366ee504b73ad19e3574f'
    end
  end

  context 'Packer version 2.3.0' do
    before do
      allow(subject).to receive(:[]).with(:platform_family).and_return(platform_family)
      allow(subject).to receive(:package_version).and_return('2.3.0')
      allow(subject).to receive(:fetch_platform_checksums_for_version).and_return(checksums)
    end
    let(:checksums) do
      [
        'eae2fd66da9ce08901ef12a3b3abc5755ad1aafae736f2d68b8885905d376f89  vagrant-2.3.0-1-x86_64.pkg.tar.zst',
        '258b1f54d623595e8af0304ca15cecc6cb368e7452eef3b5a76e88113605fc40  vagrant-2.3.0-1.i686.rpm',
        'bbceb4e93e2a13051e8388de300933839ad02ba515e7e24d1dd966a809796b34  vagrant-2.3.0-1.x86_64.rpm',
        '9d5b9a0666e249f0758d00fc6200ebf636dc070f0028239e8e26a62aad90de24  vagrant_2.3.0-1_amd64.deb',
        '1aef2489ad6bcd8a4161edc98e55925f516575ac0abcb84bffc183d0b24056bc  vagrant_2.3.0-1_i686.deb',
        '65a5fee8bcfa4bbd3be444efbcd997110a49f5ccc1fffc4457c0110ab51adecb  vagrant_2.3.0_darwin_amd64.dmg',
        '6679ea147fefc72121b949a94cc4451a6d6f58c92faf568488a3748b8612e7d0  vagrant_2.3.0_linux_amd64.zip',
        '21e5c8791d6d61f355214ac12e5744147cdd7d0e2ce2b24489171573a3daaa86  vagrant_2.3.0_windows_amd64.msi',
        '0be88e11085517cae8bb4e636fd77da865ded52bcaab5523ce70379d27713669  vagrant_2.3.0_windows_i686.msi',
      ]
    end

    it 'returns the correct Vagrant package URL' do
      expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_darwin_amd64.dmg'
    end

    it 'returns the correct SHA256 checksum for the mac_os_x package' do
      expect(subject.vagrant_sha256sum).to eq '65a5fee8bcfa4bbd3be444efbcd997110a49f5ccc1fffc4457c0110ab51adecb'
    end

    context 'rhel' do
      before do
        allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'rhel' }
      let(:platform) { 'centos' }

      it 'returns the correct Vagrant package URL' do
        expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/2.3.0/vagrant-2.3.0-1.x86_64.rpm'
      end

      it 'returns the correct SHA256 checksum for the RHEL package' do
        expect(subject.vagrant_sha256sum).to eq 'bbceb4e93e2a13051e8388de300933839ad02ba515e7e24d1dd966a809796b34'
      end
    end
    context 'debian' do
      before do
        allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'debian' }
      let(:platform) { 'ubuntu' }

      it 'returns the correct Vagrant package URL' do
        expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0-1_amd64.deb'
      end

      it 'returns the correct SHA256 checksum for the Debian package' do
        expect(subject.vagrant_sha256sum).to eq '9d5b9a0666e249f0758d00fc6200ebf636dc070f0028239e8e26a62aad90de24'
      end
    end
    context 'windows 64bit' do
      before do
        allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
        allow(subject).to receive(:[]).with('platform').and_return(platform)
        allow(subject).to receive(:[]).with('kernel').and_return(machine)
      end

      let(:platform_family) { 'windows' }
      let(:platform) { 'windows' }
      let(:machine) { { 'machine' => 'x86_64' } }

      it 'returns the correct Vagrant package URL' do
        expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_windows_amd64.msi'
      end

      it 'returns the correct SHA256 checksum for the Windows package' do
        expect(subject.vagrant_sha256sum).to eq '21e5c8791d6d61f355214ac12e5744147cdd7d0e2ce2b24489171573a3daaa86'
      end
    end

    context 'windows 32bit' do
      before do
        allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
        allow(subject).to receive(:[]).with('platform').and_return(platform)
        allow(subject).to receive(:[]).with('kernel').and_return(machine)
      end

      let(:platform_family) { 'windows' }
      let(:platform) { 'windows' }
      let(:machine) { { 'machine' => 'i686' } }

      it 'returns the correct Vagrant package URL' do
        expect(subject.vagrant_package_uri).to eq 'https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_windows_i686.msi'
      end

      it 'returns the correct SHA256 checksum for the Windows package' do
        expect(subject.vagrant_sha256sum).to eq '0be88e11085517cae8bb4e636fd77da865ded52bcaab5523ce70379d27713669'
      end
    end
  end
end
