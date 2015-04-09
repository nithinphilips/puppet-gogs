require 'spec_helper'

describe 'gogs::config', :type => :class do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "gogs::config class with parameters on #{osfamily}" do
        let(:params) do
          {
            'repository_root' => '/foo/bar',
            'owner' => 'somebody',
            'group' => 'somegroup',
            'lock_install' => false,
            'run_mode' => 'blah',
            'enable_gzip' => false,
            'domain' => 'foo.org',
            'port' => '8888',
            'db_type' => 'specialdb',
            'db_host' => 'dbhost',
            'db_port' => '123456',
            'db_user' => 'dbuser',
            'db_name' => 'database',
            'db_password' => 's3cr3t',
            'db_ssl_mode' => 'enable',
            'db_data' => 'data/gogs',
            'initrd_script' => 'initrd.centos',
            'secret_key' => 'abcd1234'
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
        it { is_expected.to contain_file('/etc/gogs/conf/app.ini')
               .with_content(/^\s*INSTALL_LOCK = false$/)
               .with_content(/^\s*RUN_MODE = blah$/)
               .with_content(/^\s*RUN_USER = somebody$/)
               .with_content(/^\s*ROOT = \/foo\/bar$/)
               .with_content(/^\s*ENABLE_GZIP = false$/)
               .with_content(/^\s*DOMAIN = foo\.org/)
               .with_content(/^\s*ROOT_URL = http:\/\/foo\.org:8888/) }
        it { is_expected.to contain_file('/etc/init.d/gogs')
               .with_owner('root')
               .with_group('root')
           }
      end
    end
  end

end
