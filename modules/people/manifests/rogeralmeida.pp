class people::rogeralmeida {
	include macvim
	include vlc
	include gimp
	include scala 
	include maven
	include jq

	class { 'intellij':
		edition => 'ultimate',
		version => '14.0.2'
	}

	$home     = "/Users/${::boxen_user}"
	$homebrew_bash = '/opt/boxen/homebrew/bin/bash'

  package { 'bash': ensure => present, provider => homebrew, }
	package { 'httpie':
		ensure => present,
		provider => homebrew
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
}
