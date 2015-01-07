# == Class gogs::config
#
# This class is called from gogs
#
class gogs::config(

  $run_mode = $gogs::run_mode,
  $repository_root = $gogs::repository_root,
  $enable_gzip = $gogs::enable_gzip,
  $domain = $gogs::domain,
  $port = $gogs::port,
  $enable_gzip = $gogs::enable_gzip,
  $db_type = $gogs::db_type,
  $db_host = $gogs::db_host,
  $db_port = $gogs::db_port,
  $db_user = $gogs::db_user,
  $db_name = $gogs::db_name,
  $db_password = $gogs::db_password,
  $db_ssl_mode = $gogs::db_ssl_mode,
  $owner = $gogs::params::owner,
  $group = $gogs::params::groups,
  $secret_key = $gogs::secret_key

) inherits gogs::params {

  File {
    owner  => $owner,
    group  => $group,
  }

  file { $repository_root:
    ensure => directory,
  }

  file { '/etc/gogs/conf/app.ini':
    ensure  => present,
    content => template('gogs/app.ini.erb'),
  }

}
