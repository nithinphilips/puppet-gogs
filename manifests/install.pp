# == Class gogs::install
#
class gogs::install {

  package { $gogs::params::package_name:
    ensure => $gogs::package_ensure,
  }
}
