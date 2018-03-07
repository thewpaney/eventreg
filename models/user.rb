class User < ActiveRecord::Base

  def authenticate(prefix, number)
    # return id if prefix-number is a match
    # return nil otherwise
  end
  
end
