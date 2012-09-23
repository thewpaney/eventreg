class User < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :name, :student_id, presence: true, uniqueness: true

  validates :student_id, :length => { :is => 5 }

  attr_accessor :student_id, :name

  belongs_to :event

  def self.authenticate(n, pass)
    if User.find(:first, :conditions=>["name = ?", n]).nil?
      return nil
    end
    if User.find(:first, :conditions=>["name = ?", n]).student_id.to_i == pass.to_i
      return u
    end
    nil
  end  
  
  # def self.store(session1, session2)
  #   u = find(:first, :conditions=>["name=? AND id=?", name, pass])
  #   unless u.nil?
  #     u.update_attributes
  #   else
  #     flash[:error] = "That operation requires you to be logged in."
  #   end
  # end

  # def self.eventid(name, pass)
  #   u = find(:first, :conditions=>["name=? AND id=?", name, pass])
  #   return u.sessionid
  # end
  
end
