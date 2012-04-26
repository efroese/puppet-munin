define munin::register (
  $host = 'absent',
  $port = '4949',
  $description = 'absent',
  $config = []
)
{
    $fhost = $name
    $client_type = 'client'

    $munin_port_real = $port

    $munin_host_real = $host ? {
        'absent' => $::fqdn,
        default => $host
    }

    @@concat::fragment{ "munin_client_${fhost}_${munin_port_real}":
        target => '/etc/munin/munin.conf',
        content => template("munin/client.erb"),
        tag => 'munin',
    }
}
