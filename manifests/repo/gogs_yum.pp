# PRIVATE CLASS: do not use directly
class gogs::repo::gogs_yum(
) inherits gogs::repo {

  yumrepo { 'rpm.packager.io-gogs':
    descr    => 'Gogs yum repo on Packager.io',
    baseurl  => "https://rpm.packager.io/gh/pkgr/gogs/centos${facts['os']['distro']['release']['major']}/pkgr",
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'https://rpm.packager.io/key',
  }

  # Ensure the repository is configured before package is installed
  Yumrepo['rpm.packager.io-gogs'] -> Package<|tag == 'gogs'|>
}
