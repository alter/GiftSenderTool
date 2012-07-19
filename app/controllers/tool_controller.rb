class ToolController < ApplicationController

  def gmtool_connection(ip="192.168.198.74", port="8088", user="vzlobin", password="1")
    apiurl = "http://#{ip}:#{port}/gametool/hessian/account.api"
    @gmtool = Hessian2::HessianClient.new(apiurl)
    @gmtool.user = user
    @gmtool.password = password
  end

  def billing_connection(ip="192.168.198.67", port="8080")
    apiurl = "http://#{ip}:#{port}/billingapi"
    @billing = Hessian2::HessianClient.new(apiurl)
  end

  def master_connection(ip="192.168.198.66", port="10500")
    apiurl = "http://#{ip}:#{port}/masterServer";
    @master = Hessian2::HessianClient.new(apiurl)
  end

  def microtime()
    epoch_mirco = Time.now.to_f;
    epoch_full = Time.now.to_i;
    return (epoch_mirco - epoch_full);
  end

  def get_transaction_id()
    if(TransactionId.last.nil?)
      TransactionId.create(:id => 0)
      return TransactionId.last[:id]
    else
    tr_id = TransactionId.last[:id] + 1
    TransactionId.create(:id => tr_id)
    return TransactionId.last[:id]
    end
  end

  def error()
    @error = params[:error]
  end

  def index
    master_connection()
  end

  def activation
    @account_name = params[:account_name]
    @shard_id     = params[:shard_id]

    master_connection()

    shard_config = @master.getShardConfig(@shard_id.to_i)
    xml_config = XmlSimple.xml_in(shard_config['config'], { 'KeyAttr' => 'name' })
    
    @gametool_host = xml_config['gametoolEAR'][0]['web'][0]['host']
    @gametool_port = xml_config['gametoolEAR'][0]['web'][0]['port']
    @shard_name = xml_config['name']

    gmtool_connection(@gametool_host, @gametool_port)
        
    respond_to :html
  end

  def sending
    @account_name  = params[:account_name]
    @shard_name    = params[:shard_name]
    @avatar_id     = params[:avatar_id]
    @code          = params[:code]
    @gametool_host = params[:gametool_host]
    @gametool_port = params[:gametool_port]
    gmtool_connection(@gametool_host, @gametool_port)
    billing_connection()
    if Present.select('ttl').where(:code => @code).count > 0
      if Present.select('ttl').where(:code => @code)[0]['ttl'] > 0
         if History.where(:code => @code, :account_name => @account_name).count == 0
           if History.where(:code => @code, :avatar_id => @avatar_id, :shard => @shard_name).count == 0
             type_id = Present.where(:code => @code).select(:types_id)[0]['types_id']
             rules_array = RulesForType.where(:types_id => type_id).select([:rules_id,:value,:stackcounter])
             rules_array.each {|rule|
              name = Rule.where(:id => rule['rules_id']).select(:name)[0]['name']
              case name
                when "add_premium_crystals"
                  currency = { 'currency' => {'name' => "HAPPY" }, 'value' => rule['value'] }
                  begin
                    @billing.addMoneyWithCurrency(@account_name, currency, 6, get_transaction_id)
                  rescue
                    @message = "Can't execute script for money"
                  end
                when "add_item"
                  item = {}
                  item = {
                      'shard' => @shard_name,
                      'avatarId' => @avatar_id.to_i,
                      'itemResourceId' => rule['value'].to_i,
                      'runeResourceId' => 0,
                      'stackCount' => rule['stackcounter'].to_i,
                      'counter' => 0,
                      'senderName' => "ActivationCodeSystem",
                      'subject' => "Gift",
                      'body' => "Hello, it's gift for you from code #{@code}"
                    }
                  items = []
                  items[0] = item
                  begin
                    @gmtool.multisendItemToAvatarByMail(items)
                  rescue
                    @message = "Can't execute script for item"
                  end
                else
                  @message = "Are you trying to hack me ?"
              end
             }
             @message = "Gift has been sent"
           else
             @message = "You have used this code !"
           end
         else
          @message = "You have used this code !"
         end
      else
        @message = "This code has been expired !"
      end
    else
      @message = "This isn't valide code!"
    end
  end
end