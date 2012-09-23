class Event < ActiveRecord::Base
  attr_accessible :maxcapacity, :name

  has_many :users

  def self.generate_html_list
    str = ""
    Event.all.sort {|a,b| a.name <=> b.name }.each do |e|
      str += "<tr><td>#{e.name} - #{e.users.count}/#{e.maxcapacity}\n"
    end
    return str
  end

  def self.is_available?(sessionid)
    e = find(:first, :conditions=>["id=?", sessionid])
    return false if e.nil?
    return true if e.users.count < e.maxcapacity
    return false
  end

#  def self.register_event(sessionid)
#    e = find(:first, :conditions=>["id=?", sessionid])
#    e.currentcapacity += 1 if is_available?(sessionid)
#    e.save
#  end

#  def self.unregister_event(sessionid)
#    e = find(:first, :conditions=>["id=?", sessionid])
#    e.currentcapacity -= 1
#    e.save
#  end
end
