class telnet {

case $::osfamily {
  'RedHat': {
    $telnetList = [
        "telnet",  ]
    package { $telnetList: }
}

  'windows': {

file {'telnetTemp':
       path => 'C:/Devops/telnet',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyTelnet64':
                path => 'C:/Devops/telnet/*',
                ensure => file,
                require => File['telnetTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/telnet/*",
        }

        exec {'InstallTelnet64':
                command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\\Devops\\telnet\\* /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyTelnet64'],
        }
       }

        default: {
        file {'CopyTelnet32':
                path => 'C:/Devops/telnet/*',
                ensure => file,
                require => File['telnetTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/telnet/*",
        }

        exec {"InstallTelnet32":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\\Devops\\telnet\\* /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyTelnet32'],
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
