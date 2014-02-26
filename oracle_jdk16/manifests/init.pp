class oracle_jdk16 {

case $::osfamily {

  'RedHat': {
  case $::hardwaremodel {
        'x86_64': {
			
			file {'CopyOLJdk1.664':
				path => '/tmp/jdk-6u38-linux-x64-rpm.bin',
				mode => 0777,
				source => "puppet://puppetlb.hcl.com/modules/oracle_jdk1.6/jdk-6u38-linux-x64-rpm.bin",
			}
        
			exec {'InstallOLJdk1.664':
				command => './tmp/jdk-6u38-linux-x64-rpm.bin',
				logoutput => true,
				source => "/tmp/jdk-6u38-linux-x64-rpm.bin",
				require => File["CopyOLJdk1.664"],
	        }
		}

	default: {
			file {'CopyOLJdk1.632':
				path => '/tmp/jdk-6u38-linux-i586-rpm.bin',
				mode => 0777,
				source => "puppet://puppetlb.hcl.com/modules/oracle_jdk1.6/jdk-6u38-linux-i586-rpm.bin",
			}
        
			exec {'InstallOLJdk1.632':
				command => './tmp/jdk-6u38-linux-i586-rpm.bin',
				logoutput => true,
				source => "/tmp/jdk-6u38-linux-i586-rpm.bin",
				require => File["CopyOLJdk1.632"],
	        }
		}
    }
  }


  'windows': {

file {'oracle_jdk1.6Temp':
       path => 'C:/Devops/oracle_jdk1.6',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyOracleW_jdk1.664':
                path => 'C:/Devops/oracle_jdk1.6/jdk-6u26-windows-x64.exe',
                ensure => file,
                require => File['oracle_jdk1.6Temp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/oracle_jdk1.6/jdk-6u26-windows-x64.exe",
        }

        exec {'InstallOracleW_jdk1.664':
                command => "C:\\Devops\\oracle_jdk1.6\\jdk-6u26-windows-x64.exe /s",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyOracleW_jdk1.664'],
        }
       }

        default: {
        file {'CopyOracleW_jdk1.632':
                path => 'C:/Devops/oracle_jdk1.6/jdk-6u26-windows-i586.exe',
                ensure => file,
                require => File['oracle_jdk1.6Temp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/oracle_jdk1.6/jdk-6u26-windows-i586.exe",
        }

        exec {"InstallOracleW_jdk1.632":
                command => "C:\\Devops\\oracle_jdk1.6\\jdk-6u26-windows-i586.exe /s",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyOracleW_jdk1.632'],
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

