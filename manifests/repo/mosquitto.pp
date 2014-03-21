# Class mosquitto::repo::mosquitto
# Author: Alex P.


class mosquitto::repo::mosquitto {
  yumrepo { 'mosquitto':
    descr    => "Mosquitto CentOS 6 Repository",
    baseurl  => "http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6/",
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => "http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6/repodata/repomd.xml.key"
  }
}
