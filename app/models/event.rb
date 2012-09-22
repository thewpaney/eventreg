class Event < ActiveRecord::Base
  attr_accessible :maxcapacity, :name, :sessionid
  
  attr_accessible :currentcapacity
  
  def self.is_available?(sessionid)
    e = find(:first, :conditions=>["id=?", sessionid])
    return false if e.nil?
    return true if e.currentcapacity < e.maxcapacity
    return false
  end

  def self.register_event(sessionid)
    e = find(:first, :conditions=>["id=?", sessionid])
    e.currentcapacity += 1 if is_available?(sessionid)
    e.save
  end

  def self.unregister_event(sessionid)
    e = find(:first, :conditions=>["id=?", sessionid])
    e.currentcapacity -= 1
    e.save
  end
end
