class RulesForType < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :rules
  has_and_belongs_to_many :types
end
