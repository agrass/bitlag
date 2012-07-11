class Tag < ActiveRecord::Base
  
  FIESTA = 1
  CONCIERTO = 2
  TEATRO = 3
  CINE = 4
  ARTE = 5
  has_and_belongs_to_many :events
  has_many :expressions
end
