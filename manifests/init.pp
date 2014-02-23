# Class: mosquitto
#
# Author: Alex P.
# This module manages mosquitto
#
# Parameters:
#
# [*manage_repo*]
# Whether the mosquitto repo should be added or not, defaults to true
# # [*manage_service*]
#  Whether to manage the mosquitto service or not
#
#
# [*service_name*]
#  Service name to manage
#
# [*conf_template*]
#  The path to a puppet template file to be rendered as the main mosquitto configuration file
#  defaults to mosquitto/mqtt.conf.erb
#
# [*manage_service*]
#  Whether to manage the mosquitto service or not
#
# [*conf_template*]
# The path to a template file, defaults to mosquitto/mqtt.conf.erb
#
# [*allow_anonymous*]
# Boolean value that determines whether clients that connect without providing a username are allowed to connect. If set to false
# then another means of connection should be created to control authenticated client access. Defaults to true.
#
# Reloaded on reload signal.
#
# [*auth_opt_qos*]
# The path to a template file, defaults to mosquitto/mqtt.conf.erb
#
# [*allow_duplicate_messages*]
# If a client is subscribed to multiple subscriptions that overlap, e.g. foo/# and foo/+/baz , then MQTT expects that when the
# broker receives a message on a topic that matches both subscriptions, such as foo/bar/baz, then the client should only receive the
# message once.
#
# Mosquitto keeps track of which clients a message has been sent to in order to meet this requirement. This option allows this
# behaviour to be disabled, which may be useful if you have a large number of clients subscribed to the same set of topics and want
# to minimise memory usage.
#
# It can be safely set to true if you know in advance that your clients will never have overlapping subscriptions, otherwise your
# clients must be able to correctly deal with duplicate messages even when then have QoS=2.
#
# Defaults to true.
#
# Reloaded on reload signal.
#
# [*conf_template*]
# The path to a template file, defaults to mosquitto/mqtt.conf.erb
#
#
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class {'mosquitto':}
#
class mosquitto (
  $manage_repo                  = true,
  $manage_service               = true,
  $service_name                 = 'mosquitto',
  $conf_template                = 'mosquitto/mqtt.conf.erb',
  $allow_anonymous              = true,
  $auth_opt_qos                 = true,
  $autosave_interval            = '1800',
  $autosave_on_changes          = true,
  $allow_duplicate_messages     = true,
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
    include mosquitto::repo::mosquitto
  }

  package { [
    'mosquitto',
    'libmosquitto-devel',
    'libmosquittopp-devel']:
    ensure  => present,
    require => [Yum::Managed_yumrepo['mosquitto']]
  }

  if $conf_template != undef {
    if $manage_service == true {
      service { $service_name: ensure => running }
      $notify_service = Service[$service_name]
    } else {
      $notify_service = undef
    }

    file { '/etc/mosquitto/conf.d/mqtt.conf':
      ensure  => file,
      content => template($conf_template),
      notify  => $notify_service,
      require => [
        Package['mosquitto'],
        Package['libmosquitto-devel'],
        Package['libmosquittopp-devel']],
    }
  }
}
