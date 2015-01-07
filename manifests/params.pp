# == Class gogs::params
#
# This class is meant to be called from gogs
# It sets variables and/or parameters according to platform
#
class gogs::params {

  # Parameter defaults
  $install_repo    = false
  $run_mode        = 'prod'
  $repository_root = '/home/gogs/gogs-repositories'
  $enable_gzip     = false
  $domain          = 'localhost'
  $port            = 6000
  $db_type         = 'postgres'
  $db_host         = 'localhost'
  $db_port         = 5432
  $db_name         = 'gogs'
  $db_user         = 'gogs'
  $db_password     = 'gogs'
  $db_ssl_mode     = 'disable'
  $secret_key      = 'jdkR3DBcXUDdznd'

  # Variables
  $owner        = 'gogs'
  $group        = 'gogs'
  $package_name = 'gogs'
  $service_name = 'gogs'

  case $::osfamily {
    'RedHat': {
    }
    'Debian': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}