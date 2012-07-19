# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120710150623) do

  create_table "histories", :force => true do |t|
    t.string   "account_name"
    t.integer  "avatar_id"
    t.string   "code",         :null => false
    t.datetime "used_at",      :null => false
    t.string   "shard",        :null => false
  end

  create_table "presents", :force => true do |t|
    t.string  "name",                   :null => false
    t.integer "types_id",               :null => false
    t.string  "code",     :limit => 32, :null => false
    t.integer "ttl",                    :null => false
  end

  create_table "rules", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "rules_for_types", :force => true do |t|
    t.integer "types_id",                    :null => false
    t.integer "rules_id",                    :null => false
    t.integer "value",                       :null => false
    t.integer "stackcounter", :default => 1, :null => false
  end

  create_table "transaction_ids", :force => true do |t|
  end

  create_table "types", :force => true do |t|
    t.string "name", :null => false
  end

end
