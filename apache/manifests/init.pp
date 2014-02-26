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
# These parameters are passed during run time. Check the <hostname>.pp file in manifests directory and moduleInstall.sh in puppet-scripts dir for further info>..
#
# apachePort,80
# apacheSslPort,443
# apacheUser,apache
# apacheGroup,apache
# apacheDocumentRoot,/var/www/html

class apache {
  include apache::params
#  include apache::ssl

case $::operatingsystem {

  'windows': {

  group { "$apacheGroup":
        ensure  => present,
  }

  user  { "$apacheUser":
        ensure  => present,
        require => Group[$apacheGroup],
  }

  file { 'ApacheTemp':
	path => "C:/apachetemp",
        ensure => directory,
        mode => 0777,
	require => User[$apacheUser],
        owner => 'Administrator',
        group => 'Administrators',
  }

  file { '$apacheDocumentRoot':
   	ensure  => directory,
	path    => $apacheDocumentRoot,
    	mode    => 0777,
	owner => 'Administrator',
        group => 'Administrators',
    	require => File['ApacheTemp'],
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyApache64':
                path => 'C:/apachetemp/apache_2.4.2-x64-openssl-1.0.1c.msi',
                require => File['ApacheTemp'],
                ensure => file,
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/apache/apache_2.4.2-x64-openssl-1.0.1c.msi",
        }

        exec {'InstallApache64':
                command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\apachetemp\apache_2.4.2-x64-openssl-1.0.1c.msi /qn /passive ALLUSERS=1 SERVERADMIN=admin@localhost SERVERNAME=localhost SERVERDOMAIN=localhost SERVERPORT=$apachePort",
                logoutput => true,
                provider => windows,
		timeout => 60,
                require => File['CopyApache64'],
        }

        file {'ModifyHttpdConf64':
                path => "C:\Program Files\Apache Software Foundation\Apache2.4\conf\httpd.conf",
                require => Exec['InstallApache64'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                content => template("apache/httpd_windows.conf.erb"),
        }

        file {'ModifySslConf64':
                path => "C:\Program Files\Apache Software Foundation\Apache2.4\conf\extra\httpd-ssl.conf",
                require => File['ModifyHttpdConf64'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                content => template("apache/httpd-ssl_windows.conf.erb"),
        }

        service { 'Apache2.4':
                hasrestart => true,
                enable => true,
                require => File['ModifySslConf64'],
                ensure => 'running',
        }


      }
	
	default: {

	file {"CopyApache32":
                path => 'C:/apachetemp/apache_2.4.2-x86-openssl-1.0.1c.msi',
                require => File['ApacheTemp'],
                ensure => file,
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/apache/apache_2.4.2-x86-openssl-1.0.1c.msi",
        }

        exec {"InstallApache32":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\apachetemp\apache_2.4.2-x86-openssl-1.0.1c.msi /qn /passive ALLUSERS=1 SERVERADMIN=admin@localhost SERVERNAME=localhost SERVERDOMAIN=localhost SERVERPORT=$apachePort",
                logoutput => "true",
                provider => windows,
		timeout => 60,
                require => File['CopyApache32'],
        }

        file {'ModifyHttpdConf32':
                path => "C:\Program Files\Apache Software Foundation\Apache2.4\conf\httpd.conf",
                require => Exec['InstallApache32'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                content => template("apache/httpd_windows.conf.erb"),
        }

        file {'ModifySslConf32':
                path => "C:\Program Files\Apache Software Foundation\Apache2.4\conf\extra\httpd-ssl.conf",
                require => File['ModifyHttpdConf32'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                content => template("apache/httpd-ssl_windows.conf.erb"),
        }

	service { 'Apache2.4':
		hasrestart => true,
	 	enable => true,
		require => File['ModifySslConf32'], 
		ensure => 'running',
        }	
       }
     }

#        exec {"StoppingApache":
#                command => 'C:\Windows\sysnative\cmd.exe /c "net stop Apache2.4"',
#                logoutput => "true",
#                provider => windows,
#                require => Exec['ModifySslConf'],
#        }

#	exec {"StartingApache":
#                command => 'C:\Windows\sysnative\cmd.exe /c "net start Apache2.4"',
#                logoutput => "true",
#                provider => windows,
#                require => Exec['StoppingApache'],
#        }
     
#        file {'RemoveDump':
#                path => 'C:\apachetemp',
#                ensure => absent,
#                require => Exec['StartingApache'],
#        }
  }
  'centos', 'fedora', 'redhat', 'scientific', 'ubuntu': {

  group { "$apacheGroup":
   	ensure  => present,
  }

  user	{ "$apacheUser":
	ensure  => present,
	require => Group[$apacheGroup],
  	gid  => "$apacheGroup",
  }

  package { 'httpd':
    ensure => installed,
    name   => $apache::params::apache_name,
    require=> User[$apacheUser],
  }
  
  file { '$apacheDocumentRoot':
    ensure  => directory,
    path    => $apacheDocumentRoot,
    mode    => '755',
    recurse => true,
    purge   => true,
  #  notify  => Service['httpd'],
    require => Package['httpd'],
  }
  
  file { "/etc/httpd/conf/httpd.conf":
   content => template("apache/httpd.conf.erb"),
  #  notify  => Service['httpd'],
    require => Package['httpd'],
  }

  case $::operatingsystem {
    'centos', 'fedora', 'redhat', 'scientific': {
      package { 'apache_ssl_package':
        ensure  => installed,
        name    => $apache::params::ssl_package,
        require => Package['httpd'],
      }
    }
    'ubuntu', 'debian': {
      a2mod { 'ssl': ensure => present, }
    }
    default: {
      fail( "${::operatingsystem} not defined in apache::ssl.")
    }
  }


  file {"/etc/httpd/conf.d/ssl.conf":
    content => template("apache/ssl.conf.erb"),
  #  notify  => Service['httpd'],
    require => Package['apache_ssl_package'],
  }
  
  service { 'httpd':
    ensure    => stopped,
    name      => $apache::params::apache_name,
    enable    => true,
    subscribe => Package['httpd'],
  }
  
  exec {"HTTP start":
    command => "/sbin/service httpd start",
    require => Service['httpd'],	
  }
 }
default: {
#      fail( "${::operatingsystem} not supported")
	notify {"${::operatingsystem} not supported":}
     }
 }
}


