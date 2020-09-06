class ApplicationRecord < ActiveRecord::Base
  include Entityable
  self.abstract_class = true
  
end
