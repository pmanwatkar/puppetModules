class openjdk17 {

case $::osfamily {
  'RedHat': {
    $openjdkList = [
        "java-1.7.0-openjdk",  ]
    package { $openjdkList: }
}

  'windows': {

file {'openjdkTemp':
       path => 'C:/Devops/jdktemp1.7',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyJdk1.764':
                path => 'C:/Devops/jdktemp1.7/*',
                ensure => file,
                require => File['openjdkTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/openjdk1.7/*",
        }

        exec {'InstallOpenJdk1.764':
                command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\\Devops\\jdktemp1.7\\* /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyJdk1.764'],
        }
       }

        default: {
        file {'CopyJdk1.732':
                path => 'C:/Devops/jdktemp1.7/*',
                ensure => file,
                require => File['openjdkTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/openjdk1.7/*",
        }

        exec {"InstallOpenJdk1.732":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\\Devops\\jdktemp1.7\\* /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyJdk1.732'],
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
