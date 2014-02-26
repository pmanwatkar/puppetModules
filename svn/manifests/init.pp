class svn {

case $::osfamily {
  'RedHat': {
    $subversionPackageList = [
        "subversion",
        "mod_dav_svn",  ]
    package { $subversionPackageList: }
}

  'windows': {

file {'svnTemp':
       path => 'C:/Devops/svntemp',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
	'x64': {
	file {'CopySvn64':
		path => 'C:/Devops/svntemp/TortoiseSVN-1.7.11.23600-x64-svn-1.7.8.msi',
		ensure => file,
		require => File['svnTemp'],
		mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/svn/TortoiseSVN-1.7.11.23600-x64-svn-1.7.8.msi",
	}

	exec {'InstallSvn64':
		command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\\Devops\\svntemp\\TortoiseSVN-1.7.11.23600-x64-svn-1.7.8.msi /qn",
		logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopySvn64'],
	}
       }

	default: {
	file {'CopySvn32':
                path => 'C:/Devops/svntemp/TortoiseSVN-1.7.11.23600-win32-svn-1.7.8.msi',
                ensure => file,
                require => File['svnTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/svn/TortoiseSVN-1.7.11.23600-win32-svn-1.7.8.msi",
        }

        exec {"InstallSvn32":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\\Devops\\svntemp\\TortoiseSVN-1.7.11.23600-win32-svn-1.7.8.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopySvn32'],
        }
       }
  }
  }
  default: {
#	fail("${::operatingsystem} not supported")
	notify{"${::operatingsystem} not supported":}
  }
 }
}
