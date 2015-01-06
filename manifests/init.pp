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
class gogs (

  $install_repo = false

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
