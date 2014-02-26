#This is the MS SQL SERVER 2008 R2 package for HCL MyDevOps 
#Variables list:
#$sysAdminActName=Administrator
#$instanceName=MSSQLSERVER



class sqlserver2008r2 {
case $::operatingsystem {
  'windows': {
  case $::hardwaremodel {
	'x64': {
	file {'SqlServerTemp':
                path => "C:/sqlservertemp",
                ensure => directory,
                mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
        }

	file {'configFile':
		path => 'C:/sqlservertemp/Configuration.ini',
		require => File['SqlServerTemp'],
		mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
		content => template("sqlserver2008r2/Configuration.ini.erb"),
	}

	file {'Copy Script':
		path => 'C:/sqlservertemp/install.bat',
		require => File['configFile'],
		mode => 0777,
                owner => 'Administrator',
                group => 'Administrators',
		content => template("sqlserver2008r2/install.bat.erb"),
	}

	exec {"MountSqlDump":
		command => 'c:\Windows\sysnative\cmd.exe /c "mount \\10.252.58.186\usr\Devops\puppet\files S:"',
		logoutput => "true",
		provider => windows,
		require => File['Copy Script'],
	}

	exec {"InstallSql":
		command => 'C:\Windows\sysnative\cmd.exe /c S:SqlServer2008R2/setup.exe /ConfigurationFile="C:/sqlservertemp/Configuration.ini"',
		require => Exec['MountSqlDump'],
		logoutput => "true",
		timeout => 3600,
                provider => windows,
	}
	
	exec {"UnmountSqlDump":
		command => 'C:\Windows\sysnative\cmd.exe /c umount -f S:',
                logoutput => "true",
                require => Exec['InstallSql'],
                provider => windows,
	}
     }
  # }
	default: {
#                fail( "${::hardwaremodel} not supported for SQL SERVER 2008 R2")
	notify => {"${::hardwaremodel} not supported for SQL SERVER 2008 R2"}
	}
  }
 }	
	default: {
#		fail( "${::operatingsystem} not supported for SQL SERVER 2008 R2")
	notify => {"${::hardwaremodel} not supported for SQL SERVER 2008 R2"}
     }
 }
}

