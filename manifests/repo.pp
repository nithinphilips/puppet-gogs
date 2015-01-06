# PRIVATE CLASS: do not use directly
class gogs::repo (

  $install_repo = false

) inherits gogs::params {

  if $install_repo {
    case $::osfamily {
      'RedHat', 'Linux': {
        class { 'gogs::repo::gogs_yum': }
      }

      'Debian': {
        class { 'gogs::repo::gogs_apt': }
      }

      default: {
        fail("Unsupported managed repository for osfamily: ${::osfamily}, operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports managing repos for osfamily RedHat and Debian")
      }
    }
  }

}
