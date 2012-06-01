class munin::plugins::setup {
  file {
    [ '/etc/munin/plugins', '/etc/munin/plugin-conf.d' ]:
      ignore => 'snmp_*',
      ensure => directory, checksum => mtime,
      recurse => true, purge => true, force => true,
      mode => 0755, owner => root, group => 0,
      notify => Service['munin-node'];
  }
}
