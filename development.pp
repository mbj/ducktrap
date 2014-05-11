$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

Exec {
path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
exec { 'apt-get -y update':
  unless => "test -e ${home}/.rvm"
}
}
class { 'apt_get_update':
  stage => preinstall
}

package { 'curl':
  ensure => installed
}

package { 'build-essential':
  ensure => installed
}

package { 'git-core':
  ensure => installed
}

package { 'zsh':
  ensure => installed
}


# Ruby dependencies.
package { ['libyaml-dev']:
  ensure => installed
}

# --- Ruby Setup ---

exec { 'install_rvm':
  command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
  creates => "${home}/.rvm",
  require => Package['curl']
}

exec { 'install_ruby':
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install 2.1.1 --autolibs=enabled'",
  creates => "${home}/.rvm/bin/ruby",
  timeout => 600,
  require => [ Package['libyaml-dev'], Exec['install_rvm'] ]
}

exec { 'set_default_ruby':
  command => "${as_vagrant} '${home}/.rvm/bin/rvm --fuzzy alias create default 2.1.1 && ${home}/.rvm/bin/rvm use default'",
  require => Exec['install_ruby']
}

exec { 'install_bundler':
  command => "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'",
  creates => "${home}/.rvm/bin/bundle",
  require => Exec['set_default_ruby']
}

# --- ZSH Setup ---

exec { 'use zsh as default shell':
  command => "chsh -s /usr/bin/zsh vagrant",
  require => [ Package['zsh'] ]
}
