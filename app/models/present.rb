class Present < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :types
  has_many :histories, :foreign_key => "code"
end
