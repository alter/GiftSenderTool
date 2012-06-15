class ToolController < ApplicationController
  def index
  end

  def activation
    @accountName = params[:accountName]
    master_gmtool_apiurl = 'http://192.168.198.74:8088/gametool/hessian/account.api'
    @client = Hessian2::HessianClient.new(master_gmtool_apiurl)
    @client.user = 'vzlobin'
    @client.password = '1'
    
    respond_to :html
  end

  def sending
  end
end
