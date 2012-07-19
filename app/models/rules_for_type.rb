class RulesForType < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :rule
  has_and_belongs_to_many :type
end
