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

  $package = $::operatingsystem ? {
    default => 'nfs',
  }

  $service = $::operatingsystem ? {
    default => 'nfs',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'nfs',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'nfs',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/nfs',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/nfs/nfs.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/nfs',
    default                   => '/etc/sysconfig/nfs',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/nfs.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/nfs',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/nfs',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/nfs/nfs.log',
  }

  $port = '42'
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
  $noops = false

}
