class History < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :presents, :foreign_key => "code"
end
