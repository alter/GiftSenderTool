class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.column 'account_name', :string, :null => true  
      t.column 'avatar_id', :integer, :null => true  
      t.column 'code', :string, :null => false 
      t.column 'used_at', :timestamp, :null => false
      t.column 'shard', :string, :null => false
    end
  end
end
