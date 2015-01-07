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
# [*run_mode*]
#   The environment this Gogs instance is running for. Allowed values are: 'dev', 'test' or
#   'prod'. Default: 'prod'
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
# [*enable_gzip*]
#   Boolean indicating wheter or not (http) gzip compression should be used. Default: false.
#
# [*db_type*]
#   The type of database back-end to be used by Gogs. Allowed values are: 'postgres' or 'mysql'.
#   Please note that the packages from packager.io, used by this module don't support sqlite3.
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
class gogs (

  $install_repo = $gogs::params::install_repo,
  $run_mode = $gogs::params::run_mode,
  $repository_root = $gogs::params::repository_root,
  $domain = $gogs::params::domain,
  $port = $gogs::params::port,
  $enable_gzip = $gogs::params::enable_gzip,
  $db_type = $gogs::params::db_type,
  $db_host = $gogs::params::db_host,
  $db_port = $gogs::params::db_port,
  $db_name = $gogs::params::db_name,
  $db_user = $gogs::params::db_user,
  $db_password = $gogs::params::db_password,
  $db_ssl_mode = $gogs::params::db_ssl_mode,
  $secret_key = $gogs::params::secret_key

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
