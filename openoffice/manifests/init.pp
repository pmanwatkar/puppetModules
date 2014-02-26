class openoffice {

case $::osfamily {
  'windows': {

  file {'openofficeTemp':
       path => 'C:/Devops/openoffice',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  file {'CopyOpenoffice':
                path => 'C:/Devops/openoffice/Apache_OpenOffice_incubating_3.4.1_Win_x86_install_en-US.exe',
                ensure => file,
                require => File['openofficeTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/openoffice/Apache_OpenOffice_incubating_3.4.1_Win_x86_install_en-US.exe",
        }

        exec {'InstallOpenOffice':
                command => "C:\\Devops\\openoffice\\Apache_OpenOffice_incubating_3.4.1_Win_x86_install_en-US.exe /S",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyOpenoffice'],
        }
  }
  default: {
#        fail("${::operatingsystem} not supported")
	notify{"${::operatingsystem} not supported":}

  }
 }
}

