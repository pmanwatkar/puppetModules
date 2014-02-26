# Class: php
#
# This module manages PHP
#
class php {

case $::osfamily {
  'RedHat': {
    $phpPackageList = [
        "php",
        "php-devel",
        "php-pear",
        "php-mysql",
        "php-xml",
        "php-xmlrpc" ]

    package { $phpPackageList: }
   }

  'windows': {
	
    file {'phpTemp':
	path => 'C:\phpTemp',
	ensure => directory,
        mode => 0777,
        owner => 'Administrator',
        group => 'Administrators',
    }
   
    file {'copyPhp':
	path => 'C:/phpTemp/php-5.3.21-win32-VC9-x86.msi',
        require => File['phpTemp'],
        ensure => file,
        mode => 0777,
        owner => 'Administrator',
        group => 'Administrators',
        source => "puppet://puppetlb.hcl.com/modules/php/php-5.3.21-win32-VC9-x86.msi",
    }

  case $::hardwaremodel {
        'x64': {
	    exec {'InstallPhp64':
		command => 'C:\Windows\sysnative\cmd.exe /c msiexec.exe /i C:\phpTemp\php-5.3.21-win32-VC9-x86.msi /q ADDLOCAL=cgi,ext_php_mysqli',
		logoutput => "true",
        	provider => windows,
	       require => File['copyPhp'],
	    }
	}
	
	 default: {
	    exec {'InstallPhp32':
		command => 'C:\Windows\System32\cmd.exe /c msiexec.exe /i C:\phpTemp\php-5.3.21-win32-VC9-x86.msi /q ADDLOCAL=cgi,ext_php_mysqli',
		logoutput => "true",
        	provider => windows,
	       require => File['copyPhp'],
	    }
	}
     }
   }

    default: {
#	        fail( "${::operatingsystem} not supported")
	notify{"${::operatingsystem} not supported":}
    } 

  }
} 


# class php

# Class: php::memcached
#
# Installs php-pecl-memcache
#
class php::memcached inherits php {

    package { "php-pecl-memcache": }
} # class php::memcached

# Class php::geshi
#
# GeSHi is Generic Syntax Highlighting
# used for mediawiki module
#
class php::geshi inherits php {
    
    package { "php-geshi": }
} # class php::geshi
