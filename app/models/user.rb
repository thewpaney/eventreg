class User < ActiveRecord::Base
  attr_accessible :student_id, :login, :first, :last, :grade, :event
  
  validates :student_id, numericality: true, uniqueness: true
  validates :login, uniqueness: true
  validates :first, :last, presence: true
  validates :grade, numericality: true
  
  belongs_to :event
  
  def self.authenticate(id, login)
    where(student_id: id, login: login.downcase).first
  end
  
  def self.registered
    where('event_id IS NOT NULL')
  end
  
  def name
    first + ' ' + last
  end
  
  def year
    %w(freshman sophomore junior senior)[(grade - 9) % 4]
  end
  
  def registration
    Rails.configuration.time[(grade - 9) % 4 + 9]
  end
  
  def registered?
    !event.nil?
  end
end
