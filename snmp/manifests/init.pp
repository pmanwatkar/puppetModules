# Class: snmp
#
# This module manages snmp and is included by the generic module
# to be applied to *ALL* nodes
#
# Requires:
#   class snmp::files
#   class lsbprovider::files
#   $snmpSyslocation must be set in site manifest, ie "$snmpSyslocation = "CompanyX NOC"
#   $contactEmail must be set in site manifest
#
class snmp {

#    include snmp::files
case $::osfamily {
  'RedHat': {

  package { "net-snmp": }

    file { "/etc/snmp/snmpd.conf":
        content => template("snmp/snmpd.conf.erb"),
        notify  => Service["snmpd"],
        require => [ Package["net-snmp"] ],
    } # file

    service { "snmpd": 
        enable  => true,
        ensure  => running,
        require => Package["net-snmp"],       
    } # service
   } # class snmp
    
  'windows': {
  	notify{"SNMP agent installed":}
  }
 
  default: {
#        fail( "${::operatingsystem} not supported")
	notify{"${::operatingsystem} not supported":}
    }
  }
}


