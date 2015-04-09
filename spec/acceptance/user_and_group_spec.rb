require 'spec_helper_acceptance'

# These tests are designed to ensure that the module, when ran with defaults,
# sets up everything correctly and allows us to connect to Postgres.
describe 'gogs', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'user and group'
  it 'adds user and group' do
    pp = <<-EOS

      $directories = ['/etc/gogs/','/etc/gogs/conf/','/home/gogs']

      file { $directories:
        ensure => 'directory',
      }
      ->
      class { '::gogs':
        package_ensure => absent,
      }
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

  describe user('gogs') do
    it { should exist }
  end

  describe group('gogs') do
    it { should exist }
  end

end