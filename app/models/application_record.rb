class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ADDRESS_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

end
