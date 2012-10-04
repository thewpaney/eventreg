class User < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :grade, :email, :login, :student_id, :firstname, :lastname, :event_id

  validates :email, :login, :student_id, presence: true, uniqueness: true
  
  validates :firstname, :lastname, presence: true

  belongs_to :event

  def self.authenticate(n, pass)
    where(:login => n, :student_id => pass).first
#    u = (User.where(:login => n).first).student_id == pass.to_i ? u : nil
    #u = User.where(name: n).first
    #u = User.find(:first, :conditions=>["name = ?", n])
    #return nil if u.nil?
    #return u if u.student_id == pass.to_i
    #nil
  end
  
end
