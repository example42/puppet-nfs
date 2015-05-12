# Class: nfs::params
#
# This class defines default parameters used by the main module class nfs
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to nfs class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class nfs::params {

  ### Application related parameters

  $mode = 'server'
  $service_status = true
  $process_args = ''
  $process_user = 'root'
  $config_dir = ''
  $config_file = '/etc/exports'
  $config_file_mode = '0644'
  $config_file_owner = 'root'
  $config_file_group = 'root'
  $pid_file = '/var/run/nfs.pid'
  $data_dir = '/etc/nfs'
  $log_dir = '/var/log/nfs'
  $log_file = '/var/log/nfs/nfs.log'


  case $::osfamily {
    'Debian', 'Ubuntu', 'Mint': {
      $package = 'nfs-common'
      $package_server = 'nfs-kernel-server'
      $service = 'nfs-kernel-server'
      $process = 'nfs'
      $config_file_init = '/etc/default/nfs'
    }
    'RedHat': {
      case $::operatingsystem {
        'RedHat', 'CentOS', 'OracleLinux', 'Scientific': {
          if (versioncmp($::operatingsystemrelease, '7.0') < 0) { # less than 7.0
            $package = 'nfs-utils'
            $package_server = ''
            $service = 'nfs'
            $process = 'nfsd'
            $config_file_init = '/etc/sysconfig/nfs'
          }
          else { #7.0+
            $package = 'nfs-utils'
            $package_server = ''
            $service = 'nfs-server'
            $process = 'nfsd'
            $config_file_init = '/etc/sysconfig/nfs'
          }
        }
        default: { fail("unsupported os ${::operatingsystem}") }
      }
    }
    default: { fail("unsupported os ${::operatingsystem}") }
  }

  $port = '2049'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false
  $mounts = {}

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = undef

}
