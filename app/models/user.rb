class User < ActiveRecord::Base
  # attr_accessible :title, :body

  validates_length_of :student_id, :within => 5..5
  validates_presence_of :name, :student_id
  validates_uniqueness_of :name, :student_id

  attr_accessor :student_id

  attr_protected :student_id, :name

  has_one :event

  def self.authenticate(name, pass)
    u = find(:first, :conditions=>["name=? AND id=?", name, pass])
    puts u.inspect
    return u unless u.nil?
    nil
  end  
  
  def self.store(session1, session2)
    u = find(:first, :conditions=>["name=? AND id=?", name, pass])
    unless u.nil?
      u.update_attributes
    else
      flash[:error] = "That operation requires you to be logged in."
    end
  end
  
end
