require "zbxapi"
Puppet::Type.type(:zabbix_api).provide(:ruby) do

  def exists?
    load_server()
    
    return @server.template.exists({"host" => resource[:name]})
  end

  def create
    load_server()
    
    hostgroup_templates = @server.hostgroup.get({
      "filter" => {
        "name" => resource[:hostgroup]
      }
    })
	@server.template.create({
	  "host"   => resource[:name], 
	  "groups" => hostgroup_templates
	})
  end

  def destroy
    load_server()
    template_hash = @server.template.get({
      "filter" => {
        "host" => resource[:name]
      }
    })
    @server.template.delete(template_hash)
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

end