# Class: mysql
#
#   This class installs mysql client software.
#
# Parameters:
#   [*client_package_name*]  - The name of the mysql client package.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mysql (
  $package_name     = $mysql::params::server_package_name,
  $package_ensure   = 'present',
  $service_name     = $mysql::params::service_name,
  $service_provider = $mysql::params::service_provider,
  $config_hash      = {},
  $enabled          = true
) inherits mysql::params {

case $::osfamily {
  'RedHat', 'FreeBSD', 'Debian': {

  Class['mysql'] -> Class['mysql::config']

  $config_class = {}
  $config_class['mysql::config'] = $config_hash

  create_resources( 'class', $config_class )

  package { 'mysql-server':
    name   => $package_name,
    ensure => $package_ensure,
  }

  if $enabled {
    $service_ensure = 'running'
  } else {
    $service_ensure = 'stopped'
  }

  service { 'mysqld':
    name     => $service_name,
    ensure   => $service_ensure,
    enable   => $enabled,
    require  => Package['mysql-server'],
    provider => $service_provider,
  }

#  package { 'mysql_client':
#    name    => $package_name,
#    ensure  => $package_ensure,
  }
 
 
  'windows': {
  
  file { 'MysqlTemp':
        path => "C:/mysqltemp",
        ensure => directory,
        mode => 0777,
        owner => 'Administrator',
        group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyMysql64':
                path => 'C:/mysqltemp/mysql-5.5.29-winx64.msi',
                require => File['MysqlTemp'],
                ensure => file,
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/mysql/mysql-5.5.29-winx64.msi",
	}

	exec {"$::hardwaremodel":
                command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\\mysqltemp\\mysql-5.5.29-winx64.msi /qn INSTALLDIR=\"C:\\Program Files\\MySQL\" ",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyMysql'],
  	}
       }
 
        default: {
	file {'CopyMysql32':
                path => 'C:/mysqltemp/mysql-5.5.29-win32.msi',
                require => File['MysqlTemp'],
                ensure => file,
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/mysql/mysql-5.5.29-win32.msi",
        }

	exec {"$::hardwaremodel":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\\mysqltemp\\mysql-5.5.29-win32.msi /qn INSTALLDIR=\"C:\\Program Files\\MySQL\" ",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyMysql32'],
        }
       }
      }

  file { 'mysqlDataDir':
        ensure  => directory,
        path    => $mysqlDataDir,
        mode    => 0777,
        owner => 'Administrator',
        group => 'Administrators',
        require => Exec["$::hardwaremodel"],
  }

  file {'ConfigFile':
	path => 'C:/mysqltemp/my.ini',
	require => File['mysqlDataDir'],
        mode => 0777,
        owner => 'Administrator',
        group => 'Administrators',
        content => template("mysql/my.ini.erb"),
  }

  exec {'ConfiguringMysql':
	command => "\"C:\\Program Files\\MySQL\\bin\\MySQLInstanceConfig.exe\" -i -q \"-lC:\\mysql_install_log.txt\" \"-cC:\\Program Files\\MySQL\\my.ini\" \"-tC:\\mysqltemp\\my.ini\" ServerType=DEVELOPMENT DatabaseType=MIXED Port=$mysqlPort ServiceName=mysqld RootPassword=$mysqlRootPassword",
	logoutput => "true",
        provider => windows,
        timeout => 60,
        require => File['ConfigFile'],
  }

  service { 'mysqld':
        hasrestart => true,
        enable => true,
        require => Exec['ConfiguringMysql'],
        ensure => 'running',  
  }
 }
  default: {
#      fail( "${::operatingsystem} not supported")
default: {
#        fail("${::operatingsystem} not supported")
	notify {"${::operatingsystem} not supported":}
  }
 }
}

  }
 }	

}
