require 'spec_helper'

describe 'rustup::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:node_params) do
        {
          'rustup::user' => 'ubuntu',
          'rustup::home_folder' => '/home/ubuntu',
        }
      end

      it { is_expected.to compile }
    end
  end
end
