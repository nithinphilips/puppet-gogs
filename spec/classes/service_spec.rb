require 'spec_helper'

describe 'gogs::service', :type => :class do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "gogs::service class without any parameters on #{osfamily}" do
        let(:facts) do
          {
            :osfamily => osfamily,
            :lsbdistid => osfamily,
            :lsbdistcodename => 'trusty'
          }
        end
        it { is_expected.to contain_service('gogs').with_ensure('running')
        }
      end
    end
  end

end
