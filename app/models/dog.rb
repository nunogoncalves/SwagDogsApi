class Dog < ActiveRecord::Base
  attr_accessible :breed, :color, :name

  validates_presence_of :name, :breed
end
