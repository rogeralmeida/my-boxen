class people::rogeralmeida {
	$home     = "/Users/${::boxen_user}"
	$homebrew_bash = '/opt/boxen/homebrew/bin/bash'

	include macvim
	include vlc
	include gimp
	include scala 
	include maven
	include jq
	include brewcask 
	include vagrant
  include skype
  include skitch
  include omnigraffle::pro

	$homebrew_packages = [ 'bash', 'httpie', 'mackup', 'tree', 'ngrok', 'graphviz', 'plantuml' ]
  package { $homebrew_packages: ensure => present, provider => homebrew }

	$brewcask_packages = ['adium', 'firefox', 'gnucash', 'evernote', 'caffeine', 
		'menucalendarclock-ical', 'dropbox', 'gimp', 'google-chrome', 'google-drive',
		'iterm2', 'keepassx', 'quicksilver', 'steam', 'sublime-text', 'virtualbox',
		'vagrant', 'spotify', 'chefdk']
	package { $brewcask_packages : provider => 'brewcask' }

	class { 'intellij':
		edition => 'ultimate',
		version => '14.0.2'
	}

  # add homebrew bash as a standard shell
  file_line { '/etc/shells':
    ensure  => present,
    line    => $homebrew_bash,
    path    => '/etc/shells',
    require => Package['bash'],
  }

  # change user shell to homebrew's
  exec { "dscl . -create ${people::rogeralmeida::home} UserShell $homebrew_bash":
    unless  => "dscl . -read /Users/${::boxen_user} UserShell | grep '$homebrew_bash' 2> /dev/null",
    user    => 'root',
    require => File_Line['/etc/shells'],
  }

  exec { "vagrant plugin install vagrant-vbguest" :
    require => Package['vagrant']
  }
}
