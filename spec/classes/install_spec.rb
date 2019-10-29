require 'spec_helper'

describe 'rustup::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:node_params) do
        {
          'rustup::user' => 'ubuntu',
          'rustup::home_folder' => '/home/ubuntu',
          'rustup::install_url' => 'https://sh.rustup.rs',
        }
      end

      it { is_expected.to compile }
    end
  end
end
