class CreatePresents < ActiveRecord::Migration
  def change
    create_table :presents do |t|
      t.column :name, :string, :limit => 255, :null => false
      t.column :types_id, :integer, :null => false
      t.column :code, :string, :limit => 32, :null => false, :unique => true
      t.column :ttl, :integer, :null => false
    end
  end
end
