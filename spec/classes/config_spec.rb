require 'spec_helper'

describe 'rustup::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'valid targets' do
        let(:node_params) do
          {
            'rustup::user' => 'ubuntu',
            'rustup::home_folder' => '/home/ubuntu',
            'rustup::releases' => ['stable', 'beta', 'nightly'],
            'rustup::targets' => ['x86_64-unknown-linux-gnu', 'aarch64-unknown-linux-gnu'],
            'rustup::profile' => 'minimal',
          }
        end

        it { is_expected.to compile }
      end

      context 'invalid targets' do
        let(:node_params) do
          {
            'rustup::user' => 'ubuntu',
            'rustup::home_folder' => '/home/ubuntu',
            'rustup::releases' => ['stable', 'beta', 'nightly'],
            'rustup::targets' => ['x86_64-unknown-linux-gnu', 'x86_64-unknown-freebsd'],
            'rustup::profile' => 'minimal',
          }
        end

        it { is_expected.not_to compile }
      end
    end
  end
end
