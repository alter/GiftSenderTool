class Type < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :present
  has_many :rules_for_type
end
