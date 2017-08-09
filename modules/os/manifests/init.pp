class os {

  package { 'mutt':
    ensure => 'installed',
  }

  package { 'numactl':
    ensure => 'installed',
  }

  user { 'monitor':
    ensure => 'present',
    home => '/home/monitor',
    shell => '/bin/bash'
  }

  file { '/home/monitor/':
     ensure => 'directory'
  }

  file { '/home/monitor/scripts':
     ensure => 'directory'
  }

}

