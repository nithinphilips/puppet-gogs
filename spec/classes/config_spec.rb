require 'spec_helper'

describe 'gogs::config', :type => :class do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "gogs::config class without any parameters on #{osfamily}" do
        let(:params) do
          {
            'repository_root' => '/foo/bar',
            'owner' => 'somebody',
            'group' => 'somegroup',
            'lock_install' => false,
          }
        end
        let(:facts) do
          {
            :osfamily => osfamily,
            :lsbdistid => osfamily,
            :lsbdistcodename => 'trusty'
          }
        end
        it { is_expected.to contain_file('/foo/bar')
               .with_ensure('directory')
               .with_owner('somebody')
               .with_group('somegroup')
           }
        it { is_expected.to contain_file('/etc/gogs/conf/app.ini') }
        it { is_expected.to contain_file('/etc/init.d/gogs')
               .with_owner('root')
               .with_group('root')
           }
      end
    end
  end

end
