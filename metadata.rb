name             'rsc_gluster'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rsc_gluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'marker'
depends 'machine_tag'
depends 'gluster'
depends 'rightscale_tag'
depends 'rsc_remote_recipe'

recipe 'rsc_gluster::default', 'verifies settings from gluster recipes'
recipe 'rsc_gluster::server', 'installs gluster server'
recipe 'rsc_gluster::server-peer-probe', 'gets peers from tag service'
recipe 'rsc_gluster::setup-replica', 'creates replica set'

attribute 'rsc_gluster/brick/path',
  :display_name => 'Gluster Brick Path',
  :description => 'Gluster Brick Path',
  :default => '/mnt/ephemeral',
  :required => 'recommended'
