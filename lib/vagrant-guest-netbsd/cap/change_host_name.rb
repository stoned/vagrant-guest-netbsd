module VagrantPlugins
  module GuestNetBSD
    module Cap
      class ChangeHostName
        def self.change_host_name(machine, name)
          if !machine.communicate.test("hostname -s | grep '^#{name}$'")
            machine.communicate.sudo("sed -e 's/^hostname=.*$/hostname=#{name}/' /etc/rc.conf > /tmp/rc.conf.vagrant_changehostname_#{name}")
            machine.communicate.sudo("mv /tmp/rc.conf.vagrant_changehostname_#{name} /etc/rc.conf")
            machine.communicate.sudo("hostname #{name}")
          end
        end
      end
    end
  end
end
