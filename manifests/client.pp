# client.pp - configure a munin node
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.
# Adapted and improved by admin(at)immerda.ch

class munin::client (
    $munin_allow = ['127.0.0.1'],
    $host = 'absent',
    $port = '4949',
    $graphing_server) {

    case $::operatingsystem {
        openbsd: { include munin::client::openbsd }
        darwin: { include munin::client::darwin }
        debian,ubuntu: { include munin::client::debian }
        gentoo: { include munin::client::gentoo }
        centos,amazon: { include munin::client::package }
        default: { include munin::client::base }
    }
    if $use_shorewall {
        include shorewall::rules::munin
    }

    include munin::client::base
}
