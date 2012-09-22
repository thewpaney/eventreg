class User < ActiveRecord::Base
  # attr_accessible :title, :body

  validates_length_of :student_id, :within => 5..5
  validates_presence_of :name, :student_id
  validates_uniqueness_of :name, :student_id

  attr_accessor :student_id

  attr_protected :student_id, :name

  def self.authenticate(name, pass)
    u = find(:first, :conditions=>["name=? AND id=?", name, pass])
    puts u.inspect
    return u unless u.nil?
    nil
  end  
  
end
