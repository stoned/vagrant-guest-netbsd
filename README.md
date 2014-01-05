# Vagrant::Guests::Netbsd

This plugin allows you to run NetBSD under [Vagrant][vagrant].

This Vagrant plugin had only been tested with Vagrant version 1.3.5

Please report any issue you will encounter.

## Installation


    $ vagrant plugin install vagrant-guest-netbsd


## Usage

Add something like the following to your `Vagrantfile`


    Vagrant.require_plugin "vagrant-guest-netbsd"
  
    Vagrant.configure("2") do |config|
      
      # Only NFS synced folder is supported
      #
      # And note that a private network with static IP
      # is required for the virtualbox provider
      config.vm.network :private_network, ip: "192.168.33.10"
      config.vm.synced_folder "/some/host/pathname", "/vagrant", type: "nfs"
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[vagrant]: http://www.vagrantup.com/ "Vagrant"
