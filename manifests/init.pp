# == Class: gogs
#
# This installs a Gogs server.
# See README.md for more details.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class gogs (
) inherits gogs::params {

  # validate parameters here

  anchor { 'gogs::begin': } ->
  class  { '::gogs::install': } ->
  class  { '::gogs::config': } ~>
  class  { '::gogs::service': } ->
  anchor { 'gogs::end': }
}
