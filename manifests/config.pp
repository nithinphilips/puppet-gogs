# == Class gogs::config
#
# This class is called from gogs
#
class gogs::config(

  $lock_install = $gogs::lock_install,
  $run_mode = $gogs::run_mode,
  $repository_root = $gogs::repository_root,
  $protocol = $gogs::protocol,
  $domain = $gogs::domain,
  $addr = $gogs::addr,
  $port = $gogs::port,
  $offline_mode = $gogs::offline_mode,
  $cert_file = $gogs::cert_file,
  $key_file = $gogs::key_file,
  $root_url = $gogs::root_url,
  $enable_gzip = $gogs::enable_gzip,
  $db_type = $gogs::db_type,
  $db_host = $gogs::db_host,
  $db_port = $gogs::db_port,
  $db_user = $gogs::db_user,
  $db_name = $gogs::db_name,
  $db_password = $gogs::db_password,
  $db_ssl_mode = $gogs::db_ssl_mode,
  $db_data = $gogs::db_data,
  $enable_mailer = $gogs::enable_mailer,
  $mailer_host = $gogs::mailer_host,
  $mailer_from = $gogs::mailer_from,
  $owner = $gogs::params::owner,
  $group = $gogs::params::group,
  $initrd_script = $gogs::params::initrd_script,
  $secret_key = $gogs::secret_key,
  $app_name = $gogs::app_name,
  $disable_registration = $gogs::disable_registration,
  $require_signin_view = $gogs::require_signin_view,
  $disable_gravatar = $gogs::disable_gravatar,
  $ssh_port = $gogs::ssh_port,
  $start_ssh_server = $gogs::start_ssh_server,


) inherits gogs::params {

  user { $owner:
    ensure  => present,
  } ->

  group { $group:
    ensure  => present,
  } ->

  file { $repository_root:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  } ->

  file { '/etc/init.d/gogs':
    ensure => 'file',
    mode   => '0755',
    source => "puppet:///modules/gogs/${initrd_script}",
    owner  => 'root',
    group  => 'root',
  } ->

  file { '/opt/gogs/custom':
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  } ->

  file { '/opt/gogs/custom/conf':
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  } ->

  file { '/opt/gogs/custom/conf/app.ini':
    ensure  => 'file',
    content => template('gogs/app.ini.erb'),
    owner   => $owner,
    group   => $group,
  }
}
