# Puppet mosquitto module #

This is a puppet module to manage mosquitto ( see http://mosquitto.org/ )

# Example usage:

    class {'nginx':
       manage_repo => true,
       manage_service => true,
       conf_template => 'mosquitto/mqtt.conf.erb'
    }

#  Paramenters:

      Key name                        Def. value.
    
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
      $max_connections              = '-1'


#### NOTE: This module has only been tested on CentOS 6.5! 