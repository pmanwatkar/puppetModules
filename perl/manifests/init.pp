class perl {

case $::osfamily {
  'RedHat': {
    $perlList = [
        "perl",  ]
    package { $perlList: }
}

  'windows': {

  file {'perlTemp':
       path => 'C:/Devops/perl',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyPerl64':
                path => 'C:/Devops/perl/ActivePerl-5.16.2.1602-MSWin32-x64-296513.msi',
                ensure => file,
                require => File['perlTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/perl/ActivePerl-5.16.2.1602-MSWin32-x64-296513.msi",
        }

        exec {'InstallPerl64':
                command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\\Devops\\perl\\ActivePerl-5.16.2.1602-MSWin32-x64-296513.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyPerl64'],
        }
       }

        default: {
        file {'CopyPerl32':
                path => 'C:/Devops/perl/ActivePerl-5.16.2.1602-MSWin32-x86-296513.msi',
                ensure => file,
                require => File['perlTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/perl/ActivePerl-5.16.2.1602-MSWin32-x86-296513.msi",
        }

        exec {"InstallPerl32":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\\Devops\\perl\\ActivePerl-5.16.2.1602-MSWin32-x86-296513.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyPerl32'],
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
