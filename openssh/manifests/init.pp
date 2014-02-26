class openssh {

case $::osfamily {
  'RedHat': {
    $opensshList = [
        "openssh",  ]
    package { $opensshList: }
}

  'windows': {

	file {'opensshTemp':
       	path => 'C:/Devops/openssh',
	       ensure => directory,
       	mode => 0777,
	       owner => 'Administrator',
       	group => 'Administrators',
	}

        file {'CopyOpenssh':
                path => 'C:/Devops/openssh/setupssh.exe',
                ensure => file,
                require => File['opensshTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/openssh/setupssh.exe",
        }

        exec {'InstallOpenssh':
                command => "C:\\Devops\\openssl\\setupssh.exe /S",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyOpenssh'],
        }
  }
  default: {
#        fail("${::operatingsystem} not supported")
	notify{"${::operatingsystem} not supported":}
  }
 }
}
