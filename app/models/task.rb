class Task < ActiveRecord::Base
  scope :done, where(:done => true).order(:due_date)
  scope :undone, where(:done => false).order("due_date DESC")
  scope :search, lambda { |query|
    where([ "name LIKE ?", "%#{query}%" ])
  }
end
