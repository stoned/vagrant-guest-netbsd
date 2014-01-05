require "tempfile"

require "vagrant/util/template_renderer"

module VagrantPlugins
  module GuestNetBSD
    module Cap
      class ConfigureNetworks
        include Vagrant::Util

        def self.configure_networks(machine, networks)
          networks.each do |network|
            ifname = "wm#{network[:interface]}"
            newrcconf = "/tmp/rc.conf.vagrant_configurenetworks_#{network[:interface]}"

            machine.communicate.sudo("sed -e '/^#VAGRANT-BEGIN/,/^#VAGRANT-END/ d' /etc/rc.conf > #{newrcconf}")

            # using templates would be cleaner but I can't find a way
            # to use templates in a non-core vagrant plugin -stoned
            machine.communicate.sudo("echo '#VAGRANT-BEGIN' >> #{newrcconf}")

            if network[:type].to_sym == :static
              machine.communicate.sudo(%Q{echo 'ifconfig_#{ifname}="media autoselect up;inet #{network[:ip]} netmask #{network[:netmask]}"' >> #{newrcconf}})
            elsif network[:type].to_sym == :dhcp
              machine.communicate.sudo("echo 'ifconfig_#{ifname}=dhcp' >> #{newrcconf}")
            end

            machine.communicate.sudo("echo '#VAGRANT-END' >> #{newrcconf}")

            machine.communicate.sudo("mv #{newrcconf} /etc/rc.conf")


            # remove old configurations
            machine.communicate.sudo("/sbin/dhcpcd -x #{ifname}", { :error_check => false })
            machine.communicate.sudo("/sbin/ifconfig #{ifname} inet delete", { :error_check => false })

            if network[:type].to_sym == :static
              machine.communicate.sudo("/sbin/ifconfig #{ifname} media autoselect up")
              machine.communicate.sudo("/sbin/ifconfig #{ifname} inet #{network[:ip]} netmask #{network[:netmask]}")
            elsif network[:type].to_sym == :dhcp
              machine.communicate.sudo("/sbin/dhcpcd -n -q #{ifname}")
            end
          end
        end
      end
    end
  end
end
