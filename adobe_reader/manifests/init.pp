class adobe_reader {

case $::osfamily {
  
  'windows': {

file {'adobe_readerTemp':
       path => 'C:/Devops/adobe_reader',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyAdobe_reader64':
                path => 'C:/Devops/adobe_reader/AdbeRdr11000_en_US.msi',
                ensure => file,
                require => File['adobe_readerTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/adobe_reader/AdbeRdr11000_en_US.msi",
        }

        exec {'InstallingAdobe_reader64':
                command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\\Devops\\adobe_reader\\AdbeRdr11000_en_US.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyAdobe_reader64'],
        }
       }

        default: {
        file {'CopyAdobe_reader32':
                path => 'C:/Devops/adobe_reader/AdbeRdr11000_en_US.msi',
                ensure => file,
                require => File['adobe_readerTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/adobe_reader/AdbeRdr11000_en_US.msi",
        }

        exec {"InstallingAdobe_reader32":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\\Devops\\adobe_reader\\AdbeRdr11000_en_US.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyAdobe_reader32'],
        }
       }
  }
  }
  default: {
        #fail("${::operatingsystem} not supported")
        notify{"${::operatingsystem} not supported":}
  }
 }
}

