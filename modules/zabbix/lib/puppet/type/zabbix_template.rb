Puppet::Type.newtype(:zabbix_template) do

  desc <<-EOT
    Install a zabbix template to a server from a given xml.

    Example:
    
        zabbix_template{ 'Template_App_Puppet':
          ensure => $present,
        }
    
  EOT

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc 'An arbitrary name used as the identity of the resource.'
  end
  
  newparam(:server) do
    desc 'URL to zabbix frontend'
  end
  
  newparam(:proxy_host) do
    desc 'proxy host if needed'
  end
  
  newparam(:proxy_password) do
    desc 'password to the proxy'
  end
  
  newparam(:user) do
    desc 'zabbix user'
  end
  
  newparam(:password) do
    desc 'zabbix users password'
  end
  
  newparam(:hostgroup) do
    desc 'hostgroup to put template into'
    defaultto "Templates"
  end

  validate do
    unless self[:name]
      raise(Puppet::Error, "zabbix_template: Both name and content are required attributes")
    end
    unless self[:server] and self[:user] and self[:password]
      raise(Puppet::Error, "zabbix_template: server configuration is required")
    end

  end
end
