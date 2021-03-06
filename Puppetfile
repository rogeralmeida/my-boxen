# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod name, :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.7.0"

# Support for default hiera data in modules

github "module_data", "0.0.3", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github 'brewcask',		"0.0.5"
github "dnsmasq",     "2.0.0"
github "gcc",         "2.2.0"
github 'gimp',        "1.0.1"
github "git",         "2.5.0"
github 'hub',         '1.4.1'
github 'heroku',			'2.1.1'
github "homebrew",    "1.12.0"
github "inifile",     "1.1.1", :repo => "puppetlabs/puppetlabs-inifile"
github 'intellij',    "1.5.1"
github 'java',        "1.8.0"
github 'jmeter',			'0.1.5'
github 'jq',          "1.0.0"
github 'maven',       "1.0.15", :repo => "rogeralmeida/puppet-maven"
github 'macvim',      "1.0.0"
github 'omnigraffle', '1.3.0', :repo => 'dieterdemeyer/puppet-omnigraffle'
github "openssl",     "1.0.0"
github "phantomjs",   "2.3.0"
github "pkgconfig",   "1.0.0"
github 'rstudio',     '1.0.0', :repo => 'taoistmath/puppet-rstudio'
github "ruby",        "8.1.4"
github 'scala',       "1.0.3", :repo => "steinim/puppet-scala"
github 'skype',       '1.1.0'
github 'skitch',      '1.0.3'
github "sudo",        "1.0.0"
github "stdlib",      "4.2.1", :repo => "puppetlabs/puppetlabs-stdlib"
github 'vagrant',     "3.2.1"
github 'vlc',         "1.0.6", :repo => "boxen/puppet-vlc"
github 'vundle',      '0.0.2', :repo => 'bdossantos/puppet-vundle'
github 'virtualbox',  '1.0.13'
github "xquartz",     "1.2.1"
github 'wget',        "1.0.1"
# Optional/custom modules. There are tons available at
# https://github.com/boxen.
