class oracle_jdk17 {

case $::osfamily {
  'RedHat': {
  case $::hardwaremodel {
        'x86_64': {
			package {'oraclejdk1.764':
				ensure => installed,
				provider => rpm,
				source => "puppet://puppetlb.hcl.com/modules/oracle_jdk1.7/jdk-7u13-linux-x64.rpm",
	        }
		}

	default: {
			package {'oraclejdk1.732':
				ensure => installed,
				provider => rpm,
				source => "puppet://puppetlb.hcl.com/modules/oracle_jdk1.7/jdk-7u13-linux-i586.rpm",
	        }
		}
    }
  }

  'windows': {

  file {'oracle_jdk1.7Temp':
       path => 'C:/Devops/oracle_jdk1.7',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyOracleW_jdk1.764':
                path => 'C:/Devops/oracle_jdk1.7/jdk-7u13-windows-x64.exe',
                ensure => file,
                require => File['oracle_jdk1.7Temp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/oracle_jdk1.7/jdk-7u13-windows-x64.exe",
        }

        exec {'InstallOracleW_jdk1.764':
                command => "C:\\Devops\\oracle_jdk1.7\\jdk-7u13-windows-x64.exe /s",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyOracleW_jdk1.764'],
        }
       }

        default: {
        file {'CopyOracleW_jdk1.732':
                path => 'C:/Devops/oracle_jdk1.7/jdk-7u13-windows-i586.exe',
                ensure => file,
                require => File['oracle_jdk1.7Temp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/oracle_jdk1.7/jdk-7u13-windows-i586.exe",
        }

        exec {"InstallOracleW_jdk1.732":
                command => "C:\\Devops\\oracle_jdk1.7\\jdk-7u13-windows-i586.exe /s",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyOracleW_jdk1.732'],
        }
       }
  }
  }
  default: {
#        fail("${::operatingsystem} not supported")
	notify{"${::operatingsystem} not supported":}
  }
 }
}

