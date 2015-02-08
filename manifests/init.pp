# This class deploys an installer from the master,
# installs it, and removes the installer to clean up.
class sl_tx {
  # temporarily stage the sl rpm so we can install the software.
  transition { 'stage sl rpm':
    resource   => File['/tmp/sl-5.02-1.el6.x86_64.rpm'],
    attributes => { ensure => file, source => 'puppet:///modules/sl_tx/sl-5.02-1.el6.x86_64.rpm' },
    prior_to   => Package['sl'],
  }

  package { 'sl':
    ensure   => installed,
    provider => rpm,
    source   => '/tmp/sl-5.02-1.el6.x86_64.rpm',
    # this before (or a require in file below) is required
    # for desired results. 
    before   => File['/tmp/sl-5.02-1.el6.x86_64.rpm'],
  }

  # clean up installer file
  file { '/tmp/sl-5.02-1.el6.x86_64.rpm':
    ensure => absent,
  }
}
