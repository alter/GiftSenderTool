class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
     t.column :name, :string, :limit => 255, :null => false, :unique => true  
    end
  end
end
