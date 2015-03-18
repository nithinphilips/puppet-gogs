require 'spec_helper'

describe 'gogs', :type => :class do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "gogs class without any parameters on #{osfamily}" do
        let(:params) do
          { }
        end
        let(:facts) do
          {
            :osfamily => osfamily,
            :lsbdistid => osfamily,
            :lsbdistcodename => 'trusty'
          }
        end
        it { is_expected.to contain_class('gogs::params') }
        it { is_expected.to contain_class('gogs::install') }
        it { is_expected.to contain_class('gogs::config') }
        it { is_expected.to contain_class('gogs::service') }
      end
    end
  end

end
