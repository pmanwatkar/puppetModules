class git {
case $::osfamily {
  'RedHat': {
    $gitPackageList = [
        "git",
        "perl-Error",
	"perl-Git", ]
    package { $gitPackageList: }
}

  'windows': {

file {'gitTemp':
       path => 'C:/Devops/gittemp',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyGit64':
                path => 'C:/Devops/gittemp/TortoiseGit-1.7.15.0-64bit.msi',
                ensure => file,
                require => File['gitTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/git/TortoiseGit-1.7.15.0-64bit.msi",
        }

        exec {'InstallingGit64':
                command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\\Devops\\gittemp\\TortoiseGit-1.7.15.0-64bit.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyGit64'],
        }
       }

        default: {
        file {'CopyGit32':
                path => 'C:/Devops/gittemp/TortoiseGit-1.7.15.0-32bit.msi',
                ensure => file,
                require => File['gitTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/git/TortoiseGit-1.7.15.0-32bit.msi",
        }

        exec {"InstallingGit32":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\\Devops\\gittemp\\TortoiseGit-1.7.15.0-32bit.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyGit32'],
        }
       }
  }
  }
  default: {
#        fail("${::operatingsystem} not supported")
	notify {"${::operatingsystem} not supported":}
  }
 }
}

