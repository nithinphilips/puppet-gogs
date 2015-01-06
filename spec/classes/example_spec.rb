require 'spec_helper'

describe 'gogs' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "gogs class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should include_class('gogs::params') }

        it { should contain_class('gogs::install') }
        it { should contain_class('gogs::config') }
        it { should contain_class('gogs::service') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'gogs class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
