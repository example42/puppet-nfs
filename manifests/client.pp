# = Class: nfs::client
#
# This is the nfs::client
#
class nfs::client {

  include nfs

  package { $nfs::package:
    ensure => $nfs::manage_package,
    noop   => $nfs::noops,
  }

}
