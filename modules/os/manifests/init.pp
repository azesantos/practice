class os {

  package { 'git':
    ensure => 'installed',
  }

  package { 'curl':
    ensure => 'installed',
  }

    package { 'vim':
    ensure => 'installed',
  }

  user { 'monitor':
    ensure => 'present',
    home => '/home/monitor',
    shell => '/bin/bash'
  }

  file { '/home/monitor/':
     ensure => 'directory',
  }

  file { '/home/monitor/scripts':
    ensure => 'directory',
    require => File['/home/monitor'],
  }

  exec { 'retrieve_memory_check':
    command => "/usr/bin/wget -O /home/monitor/scripts/memory_check --no-check-certificate https://raw.githubusercontent.com/azesantos/practice/master/modules/os/files/memory_check",
    require => File['/home/monitor/scripts'],
  }

  file { '/home/monitor/scripts/memory_check':
    ensure => 'present',
    require => Exec[retrieve_memory_check],
    mode => "u+x",
    before => File['/home/monitor/src'],
  }

  file { '/home/monitor/src':
     ensure => 'directory',
     require => File['/home/monitor'],
  }

  file { '/home/monitor/src/my_memory_check':
     ensure => 'link',
     target => '/home/monitor/scripts/memory_check',
     require => File['/home/monitor/src'],
  }

  cron { 'my_memory_check':
     command => "/home/monitor/src/my_memory_check",
     user => root,
     hour => '*',
     minute => '*/10',
     require => File['/home/monitor/src/my_memory_check'],
  }

  exec { 'sethostname':
     command => "/bin/sed -i '/HOSTNAME=/s/HOSTNAME=.*/HOSTNAME=bpx.server.local/g' /etc/sysconfig/network",
     unless => "/usr/bin/test $( cat /etc/sysconfig/network | grep ^HOSTNAME ) = 'HOSTNAME=bpx.server.local'",
     before => Exec['apply_hostname'],
  }

  exec { 'apply_hostname':
     command => "/bin/hostname bpx.server.local",
     unless => "/usr/bin/test $( /bin/hostname )  = 'bpx.server.local'",
  }


}
