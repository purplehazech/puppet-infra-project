require "zbxapi"
Puppet::Type.type(:zabbix_api).provide(:ruby) do

  def exists?
    case resource[:type]
    when "template"
      template_exists?(resource[:name])
    when "item"
      item_exists?(resource[:name], resource[:host])
    else
      raise Puppet::Error, "zabbix_api: non existant type '#{resource[:type]}'"
    end
  end

  def create
    case resource[:type]
    when "template"
      template_create(resource[:name], resource[:hostgroup])
    when "item"
      item_create(resource[:name], resource[:host], resource[:description], resource[:applications])
    end
  end

  def destroy
    case resource[:type]
    when "template"
      template_destroy(resource[:name])
    when "item"
      item_destroy(resource[:name], resource[:host])
    end
  end
  
  private
  @server
  
  def load_server
    if !@server 
      @server = ZabbixAPI.new(resource[:server])
      if resource[:proxy_host] != nil 
        @server.set_proxy(resource[:proxy_host] ,resource[:proxy_password])
      end
      @server.login(resource[:user],resource[:password])
    end
  end
  
  def template_exists?(name)
    load_server()
    return @server.template.exists({"host" => name})
  end
  
  def template_create(name, hostgroup)
    load_server()
    hostgroup_templates = @server.hostgroup.get({
      "filter" => {
        "name" => hostgroup
      }
    })
    @server.template.create({
      "host"   => name, 
      "groups" => hostgroup_templates
    })
  end
  
  def template_destroy(name)
    load_server()
    template_hash = @server.template.get({
      "filter" => {
        "host" => name
      }
    })
    @server.template.delete(template_hash)
  end
  
  def item_exists?(name, host)
    load_server()
    return @server.item.exists({"key_" => name, "host" => host})
  end
  
  def item_create(name, host, description, applications = [])
    load_server()
    unless host_exists?(host) or template_exists?(host)
      raise Puppet::Error, "missing host '#{resource[:host]}'"
    end
      
    if host_exists?(host) 
      host_array = @server.host.get({
        "filter" => {
          "host" => host
        }
      })
    elsif template_exists?(host) 
      host_array = @server.template.get({
        "filter" => {
          "host" => host
        }
      })
      host_array.collect! {|t| t = {"hostid" => t.fetch("templateid") } }
    end
    
    new = {
      "key_"         => name,
      "description"  => description,
      "applications" => applications
    }.merge(Hash[*host_array])
    
    results = @server.item.create(new)
    
    if not item_exists?(name, host)
      raise Puppet::Error, "create failed '%s'" % name
    end
  end
  
  def item_destroy(name, host)
  
    load_server()
    items = @server.item.get({
      "filter" => {
        "key_" => name,
        "host" => host
      }
    })
    items.collect! {|i| i = i.fetch('itemid')}
    @server.item.delete(Array[*items])
  end
  
  def host_exists?(name)
    load_server()
    return @server.host.exists({"host" => name})
  end

end
