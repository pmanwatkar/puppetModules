# Class: actions
# This class runs Linux and Windows actions
#
# parent,<parentName>
# script,<scriptName>
# parameters,<parameters>

class actions {

case $::osfamily {

  'windows': {

  file { 'tempWindows':
        path => "C:/Devops/temp",
        ensure => directory,
        mode => 0777,
        owner => 'Administrator',
        group => 'Administrators',
  }

  file { 'CopyActionWindows':
	path => "C:/Devops/temp/$script.bat",
	ensure => present,
	mode => 0777,
        owner => 'Administrator',
        group => 'Administrators',
	source => "puppet://puppetlb.hcl.com/modules/actions/$parent/$script.bat",
	require => File['tempWindows'],
	replace => "no",
  }


  case $::hardwaremodel {
        'x64': {
        exec {"ActionExecution64":
                command => "C:/Devops/temp/$script.bat $parameters",
                logoutput => true,
                provider => windows,
                timeout => 60,
                require => File['CopyActionWindows'],
        }
       }
        default: {
        exec {"ActionExecution32":
                command => "C:/Devops/temp/$script.bat $parameters",
		logoutput => true,
                provider => windows,
                timeout => 60,
                require => File['CopyActionWindows'],
	}
       }
    }
  }

  'RedHat': {

  file { 'tempLinux':
        path => "/tmp/Devops",
        ensure => directory,
        mode => 0777, 
	owner => 'root',
        group => 'root',    
  }
	
  file { 'CopyActionLinux':
        path => "/tmp/Devops/$script.sh",
        ensure => present,
        mode => 0777,
        owner => 'root',
        group => 'root',
        source => "puppet://puppetlb.hcl.com/modules/actions/$parent/$script.sh",
        require => File['tempLinux'],
  }

  exec { "ActionExecutionLinux":
        command => "/bin/bash /tmp/Devops/$script.sh $parameters",
        logoutput => true,
        timeout => 60,
        require => File['CopyActionLinux'],
  }
 }

  default: {
#      fail( "${::operatingsystem} not supported")
	notify {"${::operatingsystem} not supported":}
  }
 }
}





