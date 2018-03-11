class User < ActiveRecord::Base

  has_and_belongs_to_many :workshops
  
  def self.authenticate(p, n)
    u = User.where(prefix: p, number: n).first
    return u.id unless u.nil?
  end
  
end
