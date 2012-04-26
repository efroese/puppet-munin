class munin::host::cgi {
    exec{'set_modes_for_cgi':
        command => 'chgrp apache /var/log/munin /var/log/munin/munin-graph.log && chmod g+w /var/log/munin /var/log/munin/munin-graph.log && find /var/www/html/munin/* -maxdepth 1 -type d -exec chgrp -R apache {} \; && find /var/www/html/munin/* -maxdepth 1 -type d -exec chmod -R g+w {} \;',
        refreshonly => true,
        subscribe => File['/etc/munin/munin.conf'],
    }

    file{'/etc/logrotate.d/munin':
        source => [ "puppet:///modules/site-munin/config/host/${::fqdn}/logrotate",
                    "puppet:///modules/site-munin/config/host/logrotate.${::operatingsystem}",
                    "puppet:///modules/site-munin/config/host/logrotate",
                    "puppet:///modules/munin/config/host/logrotate.${::operatingsystem}",
                    "puppet:///modules/munin/config/host/logrotate" ],
        owner => root, group => 0, mode => 0644;
    }

    file { '/etc/httpd/conf.d/munin.conf':
        source => 'puppet:///modules/munin/apache-munin.conf',
        owner => root,
        group => root,
        mode => 0644
    }
}
