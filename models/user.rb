class User < ActiveRecord::Base

  def authenticate(p, n)
    u = User.where(prefix: p, number: n).first
    return u.id unless u.nil?
  end
  
end
