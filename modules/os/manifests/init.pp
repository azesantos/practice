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

  exec {'retrieve_memory_check':
    command => "/usr/bin/wget -O /home/monitor/scripts/memory_check --no-check-certificate https://raw.githubusercontent.com/azesantos/practice/master/modules/os/files/memory_check",
  }

  file {'/home/monitor/scripts/memory_check':
  require => Exec[retrieve_memory_check],
  }

}

