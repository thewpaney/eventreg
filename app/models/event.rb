class Event < ActiveRecord::Base
  attr_accessible :maxcapacity, :name

  has_many :users

  def self.generate_html_list
    str = ""
    Event.all.sort {|a,b| a.name <=> b.name }.each do |e|
      str += "<tr><td>#{e.users.count}/#{e.maxcapacity} - #{e.name}<br />"
      e.users.each do |u|
        str += "----- #{u.attributes["name"]}<br />"
      end
    end
    return str.html_safe
  end

  def self.users_registered
    return "#{User.all.find_all {|user| user.event_id != 0}.length}/#{User.all.length}"
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
