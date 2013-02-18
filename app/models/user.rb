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

  def self.unregistered
    where('event_id IS NULL')
  end

  def is_time?
     !(g = registration).nil? && ((t = Time.now.utc) - g[:open] > 0) && (t - g[:close] < 0)
  end
  
  def name
    first + ' ' + last
  end
  
  def year
    %w(freshman sophomore junior senior)[(grade - 9) % 4]
  end
  
  def registration
    p Rails.configuration.time[(grade - 9) % 4 + 9]
  end
  
  def registered?
    !event.nil?
  end

  def can_register? event
    event.restrict.nil? || event.restrict == 0 || event.restrict == grade
  end
end
