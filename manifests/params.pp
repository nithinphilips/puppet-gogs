# == Class gogs::params
#
# This class is meant to be called from gogs
# It sets variables and/or parameters according to platform
#
class gogs::params {
  case $::osfamily {
    'RedHat': {
      $package_name = 'gogs'
      $service_name = 'gogs'
    }
    'Debian': {
      $package_name = 'gogs'
      $service_name = 'gogs'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
