class tomcat6 {

case $::osfamily {
  'RedHat': {
    $tomcat6List = [
        "tomcat6",  ]
    package { $tomcat6List: }
}

  'windows': {

  file {'tomcat6Temp':
       path => 'C:/Devops/tomcat6',
       ensure => directory,
       mode => 0777,
       owner => 'Administrator',
       group => 'Administrators',
  }

        file {'CopyTomcat6':
                path => 'C:/Devops/tomcat6/apache-tomcat-6.0.36.exe',
                ensure => file,
                require => File['tomcat6Temp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/tomcat6/apache-tomcat-6.0.36.exe",
        }

        exec {'InstallTomcat6':
                command => "C:\\Devops\\tomcat6\\apache-tomcat-6.0.36.exe /S",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyTomcat6'],
        }
  
  }
  default: {
#        fail("${::operatingsystem} not supported")
	notify{"${::operatingsystem} not supported":}
  }
 }
}

