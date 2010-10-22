# Define nagios::host
#
# Use this to define Nagios host objects
# This is an exported resource.
# It should be included on the nodes to be monitored but has effects on the Nagios server
#
# Usage:
# nagios::host { "$fqdn": }
#
define nagios::host (
    $ip = $fqdn,
    $short_alias = $fqdn,
    $use = 'generic-host' ) {

    require nagios::params

    @@file { "${nagios::params::configdir}/hosts/${name}.cfg":
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        require => Class["nagios::extra"],
        notify  => Service["nagios"],
        content => template( "nagios/host.erb" ),
        tag     => 'nagios',
    }

}
