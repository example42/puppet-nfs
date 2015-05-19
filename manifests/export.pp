# This resource manages an individual export rule in /etc/exports
define nfs::export(
  $mount_point = $name,
  $hosts,
  $order       = '100',
) {
  include nfs
  include nfs::params

  if $nfs::manage_file == false {
    warn('nfs::manage_config_file has been disabled. This resource is now unused!')
  } else {
    validate_absolute_path($mount_point)
    validate_array($hosts)
    # FIXME: Add validation of hash values for host and options
    # host: one of '*', IP, IP w/ netmask, or a hostname
    # options: any of 'ro','rw','sync',wdelay...
    validate_numeric($order)

    # Create an exports fragment
    concat::fragment { "nfs_cfg_${name}":
      target  => $nfs::config_file,
      content => template($nfs::template),
      order   => $order,
    }
  }
}
