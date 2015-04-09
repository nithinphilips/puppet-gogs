require 'spec_helper'

describe 'gogs::repo', :type => :class do
  context 'Debian' do
    describe "gogs::repo class on Debian" do
      let(:params) do
        {
          'install_repo' => true
        }
      end
      let(:facts) do
        {
          :osfamily => 'Debian',
          :lsbdistid => 'Ubuntu',
          :lsbdistcodename => 'trusty'
        }
      end
      it { is_expected.to contain_class('gogs::repo::gogs_apt') }
    end
  end

  context 'RedHat' do
    describe "gogs::repo class on RedHat" do
      let(:params) do
        {
          'install_repo' => true
        }
      end
      let(:facts) do
        {
          :osfamily => 'RedHat'
        }
      end
      it { is_expected.to contain_class('gogs::repo::gogs_yum') }
    end
  end

  context 'unsupported operating system' do
    describe 'gogs::repo class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it {
        expect { should compile }.to raise_error(/Nexenta not supported/)
      }
    end
  end

end