class ftp {

case $::osfamily {
  'RedHat': {
    $ftpList = [
        "ftp",  ]
    package { $ftpList: }
}

  'windows': {

file {'ftpTemp':
       path => 'C:/Devops/ftp',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyFtp64':
                path => 'C:/Devops/ftp/FileZilla_3.6.0.2_win32-setup.exe',
                ensure => file,
                require => File['ftpTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/ftp/FileZilla_3.6.0.2_win32-setup.exe",
        }

        exec {'InstallingFtp64':
                command => "C:\\Devops\\ftp\\FileZilla_3.6.0.2_win32-setup.exe /S",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyFtp64'],
        }
       }

        default: {
        file {'CopyFtp32':
                path => 'C:/Devops/ftp/FileZilla_3.6.0.2_win32-setup.exe',
                ensure => file,
                require => File['ftpTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/ftp/FileZilla_3.6.0.2_win32-setup.exe",
        }

        exec {"InstallingFtp32":
                command => "C:\\Devops\\ftp\\FileZilla_3.6.0.2_win32-setup.exe /S",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyFtp32'],
        }
       }
  }
  }
  default: {
      #  fail("${::operatingsystem} not supported")
	notify {"${::operatingsystem} not supported":}
  }
 }
}
