I apply my puppet configuration by running

#

# puppet apply --modulepath /etc/puppet/modules /etc/puppet/manifests/site.pp
Notice: Compiled catalog for aze-vm-client-client.localdomain in environment production in 1.57 seconds
Notice: /Stage[main]/Os/Package[vim]/ensure: created
Notice: /Stage[main]/Os/Package[git]/ensure: created
Notice: /Stage[main]/Os/Package[vim]/ensure: created
Notice: /Stage[main]/Os/File[/home/monitor/]/ensure: created
Notice: /Stage[main]/Os/User[monitor]/ensure: created
Notice: /Stage[main]/Os/File[/home/monitor/scripts]/ensure: created
Notice: /Stage[main]/Os/Exec[retrieve_memory_check]/returns: executed successfully
Notice: /Stage[main]/Os/File[/home/monitor/src]/ensure: created
Notice: /Stage[main]/Os/File[/home/monitor/src/my_memory_check]/ensure: created
Notice: /Stage[main]/Os/Cron[my_memory_check]/ensure: created
Notice: /Stage[main]/Os/Exec[sethostname]/returns: executed successfully
Notice: /Stage[main]/Os/Exec[apply_hostname]/returns: executed successfully
Notice: Finished catalog run in 45.01 seconds

# rpm -qa git
git-1.7.1-2.el6_0.1.x86_64
# rpm -qa curl
curl-7.19.7-37.el6_4.x86_64

# id monitor
uid=56682(monitor) gid=56682(monitor) groups=56682(monitor)

# cat /etc/passwd | grep monitor
monitor:x:56682:56682::/home/monitor:/bin/bash

# ls -l /home/monitor/scripts/
total 12
-rw-r--r--. 1 root root 11744 Aug  9 02:26 memory_check

# # ls -l /home/monitor/src
total 0
lrwxrwxrwx. 1 root root 34 Aug  9 02:26 my_memory_check -> /home/monitor/scripts/memory_check

# crontab -l
#HEADER: This file was autogenerated at Wed Aug 09 02:26:02 -0700 2017 by puppet.
#HEADER: While it can still be managed manually, it is definitely not recommended.
#HEADER: Note particularly that the comments starting with 'Puppet Name' should
#HEADER: not be deleted, as doing so could cause duplicate cron jobs.
#Puppet Name: my_memory_check
*/10 * * * * /home/monitor/src/my_memory_check

# hostname
bpx.server.local

# cat /etc/sysconfig/network
NETWORKING=yes
HOSTNAME=bpx.server.local

