require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include macvim
  # include vlc
  include gimp
  # include scala 
  # include maven
  include jq
  include brewcask 
  include vagrant
  include skype
  include skitch
  # include omnigraffle::pro
  include heroku
  # include rstudio
  # include jmeter
  include virtualbox

  $homebrew_packages = [ 'bash', 'httpie', 'mackup', 'tree', 'ngrok', 'graphviz', 
  'plantuml', 'awscli', 'selecta', 'fasd', 'tmux', 'chromedriver' ]
  package { $homebrew_packages: ensure => present, provider => homebrew }

  $brewcask_packages = ['adium', 'firefox', 'gnucash', 'evernote', 'caffeine', 
    'menucalendarclock-ical', 'dropbox', 'gimp', 'google-chrome', 'google-drive',
    'iterm2', 'keepassx', 'quicksilver', 'steam', 'sublime-text', 
    'vagrant', 'spotify', 'chefdk', 'thunderbird']
  package { $brewcask_packages : provider => 'brewcask' }

  exec {'git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt':}
  exec {'git clone https://github.com/rogeralmeida/mydotfiles.git ~/mydotfiles':}
  exec {'ln -s ~/mydofiles/.bash_profile ~/.bash_profile':}
}

