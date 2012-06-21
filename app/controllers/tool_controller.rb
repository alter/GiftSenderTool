class ToolController < ApplicationController

  def gmtoolConnection(ip="192.168.198.74", port="8088", user="vzlobin", password="1")
    apiurl = "http://#{ip}:#{port}/gametool/hessian/account.api"
    @gmtool = Hessian2::HessianClient.new(apiurl)
    @gmtool.user = user
    @gmtool.password = password
  end

  def billingConnection(ip="192.168.198.67", port="8080")
    apiurl = "http://#{ip}:#{port}/billingapi"
    @billing = Hessian2::HessianClient.new(apiurl)
  end

  def masterConnection(ip="192.168.198.66", port="10500")
    apiurl = "http://#{ip}:#{port}/masterServer";
    @master = Hessian2::HessianClient.new(apiurl)
  end

  def index
    masterConnection()
  end

  def activation
    @account_name = params[:account_name]
    @shard_id   = params[:shard_id]

    masterConnection()

    shard_config = @master.getShardConfig(@shard_id.to_i)
    xml_config = XmlSimple.xml_in(shard_config['config'], { 'KeyAttr' => 'name' })
    
    @gametool_host = xml_config['gametoolEAR'][0]['web'][0]['host']
    @gametool_port = xml_config['gametoolEAR'][0]['web'][0]['port']
      
    gmtoolConnection(@gametool_host,@gametool_port)
    
    respond_to :html
  end

  def sending
    @account_name = params[:account_name]
    @shard_name   = params[:shard_name]
    @avatar_id    = params[:avatar_id]
    @code        = params[:code]

    gmtoolConnection()
    billingConnection()
   

  end
end
