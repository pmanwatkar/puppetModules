class python {

case $::osfamily {
  'RedHat': {
    $pythonList = [
        "python",  ]
    package { $pythonList: }
}

  'windows': {

file {'pythonTemp':
       path => 'C:/Devops/python',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

  case $::hardwaremodel {
        'x64': {
        file {'CopyPython64':
                path => 'C:/Devops/python/python-3.3.0.amd64.msi',
                ensure => file,
                require => File['pythonTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/python/python-3.3.0.amd64.msi",
        }

        exec {'InstallPython64':
                command => "C:\\Windows\\sysnative\\cmd.exe /c msiexec /i C:\\Devops\\python\\python-3.3.0.amd64.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyPython64'],
        }
       }

        default: {
        file {'CopyPython32':
                path => 'C:/Devops/python/python-3.3.0.msi',
                ensure => file,
                require => File['pythonTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/python/python-3.3.0.msi",
        }

        exec {"InstallPython32":
                command => "C:\\Windows\\System32\\cmd.exe /c msiexec /i C:\\Devops\\python\\python-3.3.0.msi /qn",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyPython32'],
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
