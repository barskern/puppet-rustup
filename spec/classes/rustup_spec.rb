require 'spec_helper'

describe 'rustup' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:node_params) do
        {
          'rustup::user' => 'ubuntu',
          'rustup::install_url' => 'https://sh.rustup.rs',
          'rustup::releases' => ['stable', 'beta', 'nightly'],
          'rustup::targets' => ['x86_64-unknown-linux-gnu'],
          'rustup::profile' => 'minimal',
        }
      end

      it { is_expected.to compile }
    end
  end
end
