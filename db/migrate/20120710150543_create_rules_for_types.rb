class CreateRulesForTypes < ActiveRecord::Migration
  def change
    create_table :rules_for_types do |t|
        t.column :types_id, :integer, :null => false
        t.column :rules_id, :integer, :null => false
        t.column :value, :integer, :null => false
        t.column :stackcounter, :integer, :null => false, :default => 1 
    end
  end
end
