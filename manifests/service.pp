# == Class gogs::service
#
# This class is meant to be called from gogs
# It ensure the service is running
#
class gogs::service {
  include gogs::params

  service { $gogs::params::service_name:
    ensure     => running,
    hasrestart => true,
    enable     => true,
  }
}
