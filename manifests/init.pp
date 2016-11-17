# == Class: gogs
#
# This installs a Gogs server.
# See README.md for more details.
#
# === Parameters
#
# [*install_repo*]
#   Boolean indicating wheter or not the gogs package repository should be added to the hosts
#   package manager configuration. Default: false.
#
# [*package_ensure*]
#   Value to pass through to the `package` resource when installing `gogs`. Defaults to
#   `present`.
#
# [*service_ensure*]
#   Value to pass through to the `service` resource when installing `gogs`. Defaults to
#   `running`.
#
# [*run_mode*]
#   The environment this Gogs instance is running for. Allowed values are: 'dev', 'test' or
#   'prod'. Default: 'prod'.
#
# [*repository_root*]
#   Root directory that will contain all Git repositories. If this directory does not exist,
#   it will be created. Please note that the parent directory for the repository root must
#   already exist! Default: '/home/gogs/gogs-repositories'
#
# [*domain*]
#   The domain name the Gogs service should serve/listen to. Default: 'localhost'.
#
# [*port*]
#   The port the Gogs service should listen on. Default: 6000.
#
# [*offline_mode*]
#   Boolean to indicate whether or not to run Gogs in offline mode. Default: false.
#
# [*root_url*]
#   The URL for accessing the Gogs service, set if behind a reverse proxy. Default: 'http://{domain}:{port}/'.
#
# [*enable_gzip*]
#   Boolean indicating wheter or not (http) gzip compression should be used. Default: false.
#
# [*db_type*]
#   The type of database back-end to be used by Gogs. Allowed values are: 'postgres', 'mysql'
#   or 'sqlite3'. Please note that the packages from packager.io, used by this module when you
#   select install_repo = true don't support sqlite3.
#   Also note that this module does not install a database for Gogs. Please use another module
#   e.g. the Puppetlabs/Postgresql module from the forge to install one.
#   Default: 'postgres'.
#
# [*db_host*]
#   The hostname of the machine where the Gogs database is running. Default: 'localhost'.
#
# [*db_port*]
#   The port of the Gogs database. Default: 5432.
#
# [*db_name*]
#   Name of the Gogs database. Default: 'gogs'.
#
# [*db_user*]
#   The username credential used for connecting to the Gogs database. Default: 'gogs'.
#
# [*db_password*]
#   The password credential used for connecting to the Gogs database. DefaulT: 'gogs'.
#
# [*db_ssl_mode*]
#   For postgres only. Valid values are: 'disable', 'require' or 'verify-full'.
#   Default: 'disable'
#
# [*db_data*]
#   Path where sqlite3 should store its data. Only used when db_type = 'sqlite3'.
#
# [*enable_mailer*]
#   Boolean to indicate whether or not to use a mail service. Default: false.
#
# [*mailer_host*]
#   SMTP mail host address and port. Default: ''.
#
# [*mailer_from*]
#   Mail from address, RFC 5322. This can be just an email address, or the “Name” <email@example.com> format. Default: ''.
#
# [*secret_key*]
#   The secret key. You should provide one for each Gogs instance. When not passed a default
#   secret key will be used.
#
# [*app_name*]
#   The application name. Default: 'Gogs: Go Git Service'.
#
# [*disable_registration*]
#   Disable registration? Default: false.
#
# [*require_signin_view*]
#   Require signin to see anything? Default: false.
#
# [*disable_gravatar*]
#   Boolean to indicate whether or not to disable gravatar. Default: false.
#
class gogs (

  $install_repo = $gogs::params::install_repo,
  $package_ensure = $gogs::params::package_ensure,
  $service_ensure = $gogs::params::package_ensure,
  $run_mode = $gogs::params::run_mode,
  $repository_root = $gogs::params::repository_root,
  $protocol = $gogs::params::protocol,
  $domain = $gogs::params::domain,
  $addr = $gogs::params::addr,
  $port = $gogs::params::port,
  $offline_mode = $gogs::params::offline_mode,
  $cert_file = $gogs::params::cert_file,
  $key_file = $gogs::params::key_file,
  $root_url = $gogs::params::root_url,
  $enable_gzip = $gogs::params::enable_gzip,
  $db_type = $gogs::params::db_type,
  $db_host = $gogs::params::db_host,
  $db_port = $gogs::params::db_port,
  $db_name = $gogs::params::db_name,
  $db_user = $gogs::params::db_user,
  $db_password = $gogs::params::db_password,
  $db_ssl_mode = $gogs::params::db_ssl_mode,
  $db_data = $gogs::params::db_data,
  $enable_mailer = $gogs::params::enable_mailer,
  $mailer_host = $gogs::params::mailer_host,
  $mailer_from = $gogs::params::mailer_from,
  $secret_key = $gogs::params::secret_key,
  $lock_install = $gogs::params::lock_install,
  $app_name = $gogs::params::app_name,
  $disable_registration = $gogs::params::disable_registration,
  $require_signin_view = $gogs::params::require_signin_view,
  $disable_gravatar = $gogs::params::disable_gravatar,
  $ssh_port = $gogs::params::ssh_port,
  $use_builtin_ssh_server = $gogs::params::use_builtin_ssh_server,

) inherits gogs::params {

  # Parameter validation
  validate_bool($install_repo)

  anchor { 'gogs::begin': } ->
  class  { '::gogs::repo': } ->
  class  { '::gogs::install': } ->
  class  { '::gogs::config': } ~>
  class  { '::gogs::service': } ->
  anchor { 'gogs::end': }

}
