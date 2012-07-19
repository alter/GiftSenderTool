class Rule < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :rules_for_types
end
