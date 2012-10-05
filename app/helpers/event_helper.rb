module EventHelper
  def self.generate_html_list
    Event.all.sort {|a, b| a.name <=> b.name }.collect {|e| "<tr><td>#{e.name.html_safe}</td><td>#{e.users.count}</td><td>#{e.capacity}</td></tr>" + e.users.collect{|u| "<tr><td></td><td></td><td>#{u.name.html_safe}</td></tr>"}}.join
  end
end
