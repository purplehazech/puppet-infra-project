require "zbxapi"
Puppet::Type.type(:zabbix_api).provide(:ruby) do

  def exists?
    case resource[:type]
    when "template"
      template_exists?(resource[:name])
    when "item"
      item_exists?(resource[:name])
    end
  end

  def create
    case resource[:type]
    when "template"
      template_create(resource[:name], resource[:hostgroup])
    end
  end

  def destroy
    case resource[:type]
    when "template"
      template_destroy(resource[:name], resource[:host])
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
  
  def item_create(name, host)
  end

end
