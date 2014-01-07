# Vagrant::Guest::Netbsd

<span class="badges">
[![Gem Version](https://badge.fury.io/rb/vagrant-guest-netbsd.png)][gem]</span>

This plugin allows you to run NetBSD under [Vagrant][vagrant].

It had been tested with Vagrant version 1.3.5 and 1.4.2.

Please report any issue you will encounter.

## Installation


    $ vagrant plugin install vagrant-guest-netbsd

## Known limitations with the VirtualBox provider

### Synced folders

VirtualBox shared folders are not supported as VirtualBox Guest Additions
are not available for NetBSD.

But Vagrant NFS synced folders are available.

It should be noted that a private ("host-only") network between the
virtualbox guest and the host must be setup to use NFS synced
folders.  The guest must also use a static IP adress in this network,
specified in the Vagrantfile.

This is required for Vagrant before version 1.4. This limitation
was removed in Vagrant 1.4 but as VirtualBox Guest Additions are
not available for NetBSD, Vagrant cannot find out the guest's address
in this network. So a static IP address in the private network is
required, no matter the version of Vagrant used.

## Usage

Add something like the following to your `Vagrantfile`


    Vagrant.require_plugin "vagrant-guest-netbsd"
  
    Vagrant.configure("2") do |config|
      
      # Only NFS synced folder are supported.
      # And note that a private network with static IP is required
      config.vm.network :private_network, ip: "192.168.33.10"
      config.vm.synced_folder "/some/host/pathname", "/vagrant", :nfs => true

    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[gem]: http://badge.fury.io/rb/vagrant-guest-netbsd
[vagrant]: http://www.vagrantup.com/ "Vagrant"
