# Class: mosquitto
#
# This module manages mosquitto
#
# Parameters: 
# [*manage_repo*] - Ensures the mosquitto repo is added, automatically
# [*conf_template*] - The path to the template file,
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class mosquitto (
  $manage_repo                  = true,
  $conf_template                = 'mosquitto/mqtt.conf.erb',
  $global_opts                  = undef,
  $allow_anonymous              = true,
  $auth_opt_qos                 = true,
  $connection_messages          = true,
  $max_inflight_messages        = '0',
  $max_queued_messages          = '0',
  $message_size_limit           = '0',
  $persistence                  = true,
  $persistent_client_expiration = '30m',
  $queue_qos0_messages          = false,
  $listen_ip                    = '0.0.0.0',
  $listen_port                  = '2000',
  $max_connections              = '-1') {
  if $manage_repo == true {
    yum::managed_yumrepo { 'mosquitto':
      descr    => "Mosquitto CentOS 6 Repository",
      baseurl  => "http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6/",
      enabled  => 1,
      gpgcheck => 1,
      gpgkey   => "http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6/repodata/repomd.xml.key"
    }
  }

  package { [
    'mosquitto',
    'libmosquitto-devel',
    'libmosquittopp-devel']:
    ensure  => present,
    require => [Yum::Managed_yumrepo['mosquitto']]
  }

  if $conf_template != undef {
    file { '/etc/mosquitto/conf.d/mqtt.conf':
      ensure  => file,
      content => template($conf_template),
      require => [
        Package['mosquitto'],
        Package['libmosquitto-devel'],
        Package['libmosquittopp-devel']]
    }
  }
}