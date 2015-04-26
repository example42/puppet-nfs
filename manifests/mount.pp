#
define nfs::mount(
  $server,
  $share,
  $mountpoint     = '',
  $ensure=present,
  $client_options='auto',
) {

  if !defined(Class['nfs']) {
    class {'nfs':
      mode  => 'client'
    }
  }

  $real_mountpoint = $mountpoint?{
    ''      => $name,
    default => $mountpoint
  }

  mount {"shared ${share} by ${server}":
    device   => "${server}:${share}",
    fstype   => 'nfs',
    name     => $real_mountpoint,
    options  => $client_options,
    remounts => false,
    atboot   => true,
  }

  case $ensure {
    present: {
      exec {"create ${real_mountpoint} and parents":
        command => "mkdir -p ${real_mountpoint}",
        unless  => "test -d ${real_mountpoint}",
      }
      Mount["shared ${share} by ${server}"] {
        require => [Exec["create ${real_mountpoint} and parents"], Class['nfs::client']],
        ensure  => mounted,
      }
    }

    absent: {
      Mount["shared ${share} by ${server}"] {
        ensure => unmounted,
      }
    }

    default: { }
  }

}
