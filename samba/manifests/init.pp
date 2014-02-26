class samba {

case $::osfamily {
  'RedHat': {
    $sambaList = [
        "samba",  ]
    package { $sambaList: }
  }


default: {
        notify{"${::operatingsystem} not supported":}
  }
 }
}
