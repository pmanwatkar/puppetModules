# Class: apache
#
# This class installs Apache
#
# Parameters:
#
# Actions:
#   - Install Apache
#   - Manage Apache service
#
# Requires:
#
# Sample Usage:
#
class apache (
	$apache_port	  	= extlookup("apache_port"),
	$apache_user	  	= extlookup("apache_user"),
	$apache_group   	= extlookup("apache_group"),
	$apache_sslport 	= extlookup("apache_sslport"),
       $apache_documentroot	= extlookup("apache_documentroot"),
)
{
  include apache::params
  include apache::ssl

  group { "$apache_group":
   	ensure  => present,
  }

  user	{ "$apache_user":
	ensure  => present,
	require => Group["$apache_group"],
  	gid  => "$apache_group",
  }

  package { 'httpd':
    ensure => installed,
    name   => $apache::params::apache_name,
  }
  
  service { 'httpd':
    ensure    => running,
    name      => $apache::params::apache_name,
    enable    => true,
    subscribe => Package['httpd'],
  }
  
  file { '$apache_documentroot':
    ensure  => directory,
    path    => $apache_documentroot,
    mode    => '755',
    recurse => true,
    purge   => true,
    notify  => Service['httpd'],
    require => Package['httpd'],
  }
  
  file { "/etc/httpd/conf/httpd.conf":
   content => template("apache/httpd.conf.erb"),
    notify  => Service['httpd'],
    require => Package['httpd'],
  }

  file {"/etc/httpd/conf.d/ssl.conf":
    content => template("apache/ssl.conf.erb"),
    notify  => Service['httpd'],
    require => Package['httpd'],
  }

 exec {'/etc/init.d/httpd restart':}

}



