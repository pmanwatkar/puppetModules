class lamp{
case $::osfamily {
  'RedHat': {

	package { "httpd":
		ensure => present
	}
	service { "httpd":
		ensure => running,
		require => Package["httpd"],
	}
	package { "mysql-server":
		ensure => present
	}
	service { "mysqld":
		ensure => running,
		require => Package["mysql-server"],
	}

	$phpPackageList = [
        "php",
        "php-devel",
        "php-pear",
        "php-mysql",
        "php-xml",
        "php-xmlrpc" ]
	package { $phpPackageList: }
	
  }
  default: {
#        fail("${::operatingsystem} not supported")
	notify {"${::operatingsystem} not supported":}
  }
 }
}

