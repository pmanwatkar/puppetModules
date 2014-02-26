class gcc {

case $::osfamily {
  'RedHat': {
    $gccList = [
        "gcc",  ]
    package { $gccList: }
}

  default: {
#        fail("${::operatingsystem} not supported")
	notify {"${::operatingsystem} not supported":}
  }
 }
}
