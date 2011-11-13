class Category < ActiveRecord::Base
  has_many :tasks, :dependent => :nullify
end
