#wamp_apachePort,80
#wamp_apacheUser,Administrator
#wamp_apacheGroup,Administrators>
#wamp_apacheDocumentRoot,C:/wamp/www
#wamp_apacheSslPort,443
#wamp_mysqlPort,3306
#wamp_mysqlBindAddress,0.0.0.0
#wamp_mysqlDataDir,C:/mysql/data

class wamp20i {

case $::osfamily {

  'windows': {

	file {'wamp2.0iTemp':
       	path => 'C:/Devops/wamp2.0i',
	       	ensure => directory,
	      	mode => 0777,
       		owner => 'Administrator',
	        group => 'Administrators',
  	}

        file {'CopyWamp2.0i':
                path => 'C:/Devops/wamp2.0i/WampServer2.0i.exe',
                ensure => file,
                require => File['wamp2.0iTemp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/wamp20i/WampServer2.0i.exe",
        }

	file {'CopyWamp2.0iSilent':
                path => 'C:/Devops/wamp2.0i/SilentInstall.exe',
                ensure => file,
                require => File['CopyWamp2.0i'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                source => "puppet://puppetlb.hcl.com/modules/wamp20i/SilentInstall.exe",
        }

        exec {'Installwamp':
                command => "C:/Devops/wamp2.0i/WampServer2.0i.exe /sb /verysilent /DIR=c:\\wamp",
                logoutput => "true",
                provider => windows,
                timeout => 60,
                require => File['CopyWamp2.0iSilent'],
        }

        exec {'Waitwamp':
		command => "C:\\Windows\\sysnative\\cmd.exe powershell.exe sleep 120",
                logoutput => "true",
                provider => windows,
                timeout => 120,
                require => Exec['Installwamp'],
        }

	file {'ModifyHttpdConfwamp':
                path => "C:\wamp\bin\apache\Apache2.2.11\conf\httpd.conf",
                require => Exec['Waitwamp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                content => template("wamp20i/httpd_windows.conf.erb"),
        }

        file {'ModifySslConfwamp':
                path => "C:\wamp\bin\apache\Apache2.2.11\conf\extra\httpd-ssl.conf",
                require => File['ModifyHttpdConfwamp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                content => template("wamp20i/http-ssl_windows.conf.erb"),
        }

	file {'ModifyMysqlConfwamp':
		path => "C:\wamp\bin\mysql\mysql5.5.8\my.ini",
		require => File['ModifySslConfwamp'],
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
                content => template("wamp20i/my.ini.erb"),
	}

  case $::hardwaremodel {
        'x64': {

	exec {'StartWamp64':
		command => "C:\\Windows\\sysnative\\cmd.exe start C:\\wamp\\wampmanager.exe",
                logoutput => "true",
                provider => windows,
                timeout => 10,
                require => File['ModifyMysqlConfwamp'],
	}
       }

        default: {
        exec {'StartWamp32':
		command => "C:\\Windows\\System32\\cmd.exe start C:\\wamp\\wampmanager.exe",
                logoutput => "true",
                provider => windows,
                timeout => 10,
                require => File['ModifyMysqlConfwamp'],
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

