class User < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :name, :student_id, presence: true, uniqueness: true

  validates :student_id, :length => { :is => 5 }

  belongs_to :event

  def self.authenticate(n, pass)
    u = (User.where(name: n).first).student_id == pass.to_i ? u : nil
    #u = User.where(name: n).first
    #u = User.find(:first, :conditions=>["name = ?", n])
    #return nil if u.nil?
    #return u if u.student_id == pass.to_i
    #nil
  end  
  
end
