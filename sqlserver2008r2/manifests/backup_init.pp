class sqlserver2008r2 {
	case $::operatingsystem {
  		'windows': {

	file {'SqlServer':
                path => "C:/sqlserverdump",
                ensure => directory,
                mode => 0777,
        }

        file {'copyingDB':
                ensure => file,
		recurse => true,
		path => 'C:/sqlserverdump/SqlServer2008R2.zip',
                require => File['SqlServer'],
                mode => 0777,
                source => "puppet://puppetlb.hcl.com/modules/sqlserver2008r2/sqlServer2008R2.zip",
        }
	
	file {'copyingScript':
		path => 'C:/sqlserverdump/unzip.ps1',
		require => File['copyingDB'],
		mode => 0777,
		source => "puppet://puppetlb.hcl.com/modules/sqlserver2008r2/unzip.ps1",
	}

	file {'configFile':
		path => 'C:/sqlserverdump/Configuration.ini',
		require => File['copyingScript'],
		mode => 0777,
		content => template("sqlserver2008r2/Configuration.ini.erb"),
	}

	exec {"unzipping": 
		command => 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -file C:/sqlserverdump/unzip.ps1',
		logoutput => true,
		require => File['configFile'],
	}

	exec {"installing":
		command => 'C:\Windows\System32\cmd.exe /c C:/sqlserverdump/SqlServer2008R2/setup.exe /ConfigurationFile="C:/sqlserverdump/Configuration.ini"',
		require => Exec['unzipping'],
		logoutput => true,
	}
	
     }

	default: {
		fail( "${::operatingsystem} not supported for SQL SERVER 2008 R2")
     }
 }
}

