node 'django' {
    require webserver
    # hosts {}

    python::virtualenv {
        "/home/vagrant/.virtualenv":
        ensure       => present,
        version      => 'system',
        requirements => '/vagrant/configs/requirements.txt',
        # systempkgs   => false,
        # distribute   => true,
        owner        => 'vagrant',
        group        => 'vagrant',
    }

    file { "/etc/nginx/sites-enabled/django.conf":
        ensure => file,
        mode   => 644,
        content => template("/vagrant/puppet/templates/nginx.django.erb"),
        group  => 'root',
        owner  => 'root',
    }

    file { "/etc/supervisor/conf.d/django.conf":
        ensure => file,
        mode   => 644,
        content => template("/vagrant/puppet/templates/supervisor.django.erb"),
        group  => 'root',
        owner  => 'root',
    }
    service { 'supervisor':
      ensure    => running,
      enable    => true,
      subscribe => File['/etc/supervisor/conf.d/django.conf'],
    }
}

class webserver {
    include stdlib
    class { 'apt':
        always_apt_update    => true,
        # disable_keys         => undef,
        # proxy_host           => false,
        # proxy_port           => '8080',
        purge_sources_list   => false,
        purge_sources_list_d => false,
        purge_preferences_d  => false,
        # update_timeout       => undef
    }

    require webserver::service::nginx
    require webserver::service::mysql
    require webserver::service::python
    require webserver::service::supervisord
    require webserver::service::nodejs
}

class webserver::service::nginx {
    apt::key { "nginx-stable":
        key        => "7BD9BF62",
        key_source => "http://nginx.org/keys/nginx_signing.key",
    }

    apt::source { 'nginx':
        location     => 'http://nginx.org/packages/ubuntu/',
        repos        => 'nginx',
        include_src  => true,
    }

    $nginx_required_packages = ["nginx-full"]
    package { $nginx_required_packages:
        provider => apt,
        ensure   => latest,
        require => Class["apt::update"]
    }

    file { '/etc/nginx/sites-enabled/':
        ensure => "directory",
        purge => true,
        recurse => true,
        group  => 'root',
        owner  => 'root',
        require => Package[$nginx_required_packages],
    }

    service { 'nginx':
        ensure    => running,
        enable    => true,
        require   => Package[$nginx_required_packages],
    }
}

class webserver::service::mysql {
    $mysql_required_packages = ["mysql-server", "mysql-client", "libmysqlclient-dev"]
    package { $mysql_required_packages:
        provider => apt,
        ensure   => latest,
        require => Class["apt::update"]
    }
}

class webserver::service::python {
    $python_required_packages = ["python", "python-virtualenv", "python-dev", "python-setuptools"]
    package { $python_required_packages:
        provider => apt,
        ensure   => latest,
        require => Class["apt::update"]
    }
}

class webserver::service::supervisord {
    $supervisord_required_packages = ["supervisor"]
    package { $supervisord_required_packages:
        provider => apt,
        ensure   => latest,
        require => Class["apt::update"]
    }
}

class webserver::service::nodejs {
    apt::ppa { 'ppa:chris-lea/node.js': }

    $node_required_packages = ["nodejs"]
    package { $node_required_packages:
        provider => apt,
        ensure   => latest,
        require => [Class["apt::update"], Apt::Ppa['ppa:chris-lea/node.js']]
    }

    # file { '/etc/nginx/sites-enabled/':
    #     ensure => "directory",
    #     purge => true,
    #     recurse => true,
    #     group  => 'root',
    #     owner  => 'root',
    #     require => Package[$nginx_required_packages],
    # }

    # service { 'nginx':
    #     ensure    => running,
    #     enable    => true,
    #     require   => Package[$nginx_required_packages],
    # }
}
