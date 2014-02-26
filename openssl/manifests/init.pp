class openssl {

case $::osfamily {
  'RedHat': {
    $opensslList = [
        "openssl",  ]
    package { $opensslList: }
  }

  'windows': {

	file {'opensslTemp':
       	path => 'C:/Devops/openssl',
	       ensure => directory,
       	mode => 0777,
	       owner => 'Administrator',
       	group => 'Administrators',
  	}

        file {'CopyOpenssl':
                path => 'C:/Devops/openssl/openssl-0.9.8h-1-setup.exe',
                ensure => file,
                require => File['opensslTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/openssl/openssl-0.9.8h-1-setup.exe",
        }

        exec {'InstallOpenssl':
                command => "C:\\Devops\\openssl\\openssl-0.9.8h-1-setup.exe /silent /verysilent /sp- /suppressmsgboxes",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyOpenssl'],
        }
  }
  default: {
#        fail("${::operatingsystem} not supported")
	notify{"${::operatingsystem} not supported":}
  }
 }
}
