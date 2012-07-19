module ToolHelper
    def get_avatars(gmtool_handler, account_name, shard_name)
      begin
        gmtool_handler.getAvatars(account_name)
      rescue
        capture_haml do
          haml_tag :script, :type => "text/javascript" do
            haml_concat "window.location='#{tool_error_url}?error=GM Tool: #{$!}'"
          end
        end
      else
        capture_haml do
          haml_tag(:select, :name => "avatar_id") do
            gmtool_handler.getAvatars(account_name).each do |avatar|
              if((!avatar['deleted']) && (avatar['shard'] == shard_name))
                haml_tag :option, :value => avatar['avatarId'] do
                  haml_concat avatar['avatar']
                end
              end
            end
          end
        end
      end
    end
end
