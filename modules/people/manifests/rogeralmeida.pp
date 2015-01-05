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

	$brewcask_packages = ['adium', 'firefox', 'gnucash']
	package { $brewcask_packages : provider => 'brewcask' }

	$homebrew_packages = [ 'bash', 'httpie', 'mackup' ]
  package { $homebrew_packages: ensure => present, provider => homebrew }

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
}
