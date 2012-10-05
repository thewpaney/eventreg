class Event < ActiveRecord::Base
  attr_accessible :capacity, :name
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
    self.count :conditions => ['event_id IS NOT NULL']
  end

  def self.is_available? id
    !(e = self.find(id)).nil? && e.users.count < e.capacity
  end
end
