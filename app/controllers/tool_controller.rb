class ToolController < ApplicationController
  def index
  end

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

  def activation
    @accountName = params[:accountName]
    gmtoolConnection()
    
    respond_to :html
  end

  def sending
    @accountName = params[:accountName]
    @shardName   = params[:shardName]
    @avatarId    = params[:avatarId]
    @code        = params[:code]

    gmtoolConnection()
    billingConnection()

    

  end
end
