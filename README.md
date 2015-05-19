# Puppet module: nfs

This is a Puppet module for nfs based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-nfs

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install nfs with default settings (Server mode)

        class { 'nfs': }

* Install only nfs client pacakges

        class { 'nfs':
          mode => 'client',
        }

  or 

        include nfs::client

* Install a specific version of nfs

        class { 'nfs':
          version => '1.0.1',
        }

* Disable nfs service.

        class { 'nfs':
          disable => true
        }

* Remove nfs package

        class { 'nfs':
          absent => true
        }

* Enable auditing without without making changes on existing nfs configuration *files*

        class { 'nfs':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'nfs':
          noops => true
        }

* Mounting NFS shares

        nfs::mount { '/mnt/bigdata':
          server         => '127.0.0.1',    #required
          share          => '/bigdata',     #required
          mountpoint     => '/mnt/bigdata', #if empty defaults to the resource name
          ensure         => present,        #default is 'present', can also be 'absent'
          client_options => '',             #default is 'auto'
        }

'client_options' is a passthrough to the [mount type options attribute] (https://docs.puppetlabs.com/references/latest/type.html#mount-attribute-options).
If the mountpoint directory does not exist it will be created along with any parent directories that don't exist, essentially 'mkdir -p $mountpoint'.

* Exporting NFS shares (server only)

        nfs::export { '/var/log':
          hosts => [{                 # Hosts must be wrapped in [] even if it is a single entry
            'host' => '*',            # Host can be '*', IP, IP w/ netmask, or hostname
            'options' => 'ro,fsid=0'  # Host specific nfs options
          },
          order => 10                 # Optional, order to arrange export entries. Defaults to 100
        }]

* Another example with multiple access control entries

        nfs::export { '/opt/tomcat/webapps':
          hosts => [
            {
              'host' => 'host.example.com',
              'options' => 'rw'
            },
            {
              'host' => '192.168.56.0/24',
              'options' => 'rw,sync'
            },
            {
              'host' => '*',
              'options' => 'ro,fsid=0'
            }
          ]
        }

## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'nfs':
          source => [ "puppet:///modules/example42/nfs/nfs.conf-${hostname}" , "puppet:///modules/example42/nfs/nfs.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'nfs':
          source_dir       => 'puppet:///modules/example42/nfs/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'nfs':
          template => 'example42/nfs/nfs.conf.erb',
        }

* Automatically include a custom subclass

        class { 'nfs':
          my_class => 'example42::my_nfs',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'nfs':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'nfs':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'nfs':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'nfs':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-nfs.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-nfs]
