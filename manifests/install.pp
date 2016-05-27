# == Class gogs::install
#
class gogs::install(

  $package_name   = $gogs::params::package_name,
  $package_ensure = $gogs::package_ensure

) {

  package { $package_name:
    ensure => $package_ensure,
  } ->
  # The following service is installed through the rpm and must be stopped first
  exec { 'Stopping_gogs_via_initctl':
    command => 'initctl stop gogs',
    cwd     => '/etc/init',
    path    => ['/sbin', '/usr/bin'],
    onlyif  => ['test -f /etc/init/gogs.conf', 'test -f /etc/init/gogs-web-1.conf', 'test -f /etc/init/gogs-web.conf'],
  } ->
  # The following files are installed through the rpm and must be removed
  file { ['/etc/init/gogs.conf', '/etc/init/gogs-web-1.conf', '/etc/init/gogs-web.conf']:
    ensure => absent,
  }
}
