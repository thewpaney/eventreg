module EventHelper
  def self.generate_html_list
    Event.all.sort {|a, b| a.name <=> b.name }.collect {|e| "<tr><td>#{e.name.html_safe}</td><td><strong>#{e.users.count}/#{e.capacity}</strong></td></tr>" + e.users.collect{|u| "<tr><td></td><td></td><td>#{u.name.html_safe}</td></tr>"}.join}.join
  end

  def self.generate_html_overfull
    Event.all.sort {|a, b| a.name <=> b.name }.collect {|e| e.users.count > e.capacity ? "<tr><td><strong>#{e.users.count}/#{e.capacity}</strong> - </td><td>#{e.name.html_safe}</td></tr>" : nil }.join
  end
end
