require 'spec_helper_acceptance'

# These tests are designed to ensure that the module, when ran with defaults,
# sets up everything correctly and allows us to connect to Postgres.
describe 'gogs', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'with defaults' do
    pp = <<-EOS
      class { '::gogs': }
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

end
